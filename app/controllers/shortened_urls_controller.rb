class ShortenedUrlsController < ApplicationController

  def redirect
    url = ShortenedUrl.fetch_with_token(token: params[:id])
    redirect_to url, status: :moved_permanently
  end

  def new
    @shortened_url = ShortenedUrl.new
    if params[:id]
      short_url = ShortenedUrl.find_by "unique_key = ?", params[:id]
      if short_url
        @short_url = root_url + short_url.unique_key
      else
        redirect_to root_path
      end
    end
  end

  def create
    @shortened_url = ShortenedUrl.new(url: shortened_url_params[:url], unique_key: 'a')
    if @shortened_url.valid?
      redirect_to shortened_path(ShortenedUrl.generate(shortened_url_params[:url]))
      flash[:notice] = 'Shortened url was successfully created.'
    else
      render :new, notice: 'Failed to generate Shortened Url.'
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortened_url_params
      params.require(:shortened_url).permit(:url)
    end
end
