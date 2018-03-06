# Dia&Co. Engineering Team Homework

In answering the assignment, please submit code as if you intended to ship it to production. We want to see your best work :smile:. Please make sure to write tests!

We believe this should take less than 4 hours to complete, but understand you may have other commitments and time constraints. Please let us know (roughly) when we should expect your answers (e.g. “over the weekend”). Let us know if you need more time.

## Task

Build a simple URL shortening service (like Bit.ly). Your service should meet the requirements below.

## Specifics

* The home page of your app should have a text field for the user to enter a URL and a submit button to request the shortened URL.
* When the User submits their entered URL, return back a unique shortened URL for them to use. (You only need to worry about the path of the URL, not the domain... assume this code will be deployed on a domain that is already short, like “dia.co”).
* Your site should properly handle using the shortened URLs:  Requests to shortened URLs should redirect to the original URL.
* Handle basic errors: If the user enters a garbage URL to be shortened, return back an error message that the input needs to be a proper URL.

## Implementation

* Your code should be a Rails app.
* Feel free to use any gems/frameworks that you deem helpful.
* Remember there is no need for any login/authentication system for this project.

## Examples:
Input: http://www.google.com
Output: http://localhost:3000/zy3F23f1
 
Input: aefoiheafioh
Output: [Error -- this does not look like a valid URL]

## Deliverables

Send us a ZIP file of your entire codebase, along with any special instructions to use it beyond starting the server and visiting localhost:3000 :smile:.
