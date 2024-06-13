# SPA using the Curity Token Handler

[![Quality](https://img.shields.io/badge/quality-production-green)](https://curity.io/resources/code-examples/status/)
[![Availability](https://img.shields.io/badge/availability-source-blue)](https://curity.io/resources/code-examples/status/)

A Single Page Application (SPA) that implements OpenID Connect using recommended browser security.\
The SPA uses a `Backend for Frontend (BFF)` approach, in line with [best practices for browser based apps](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-browser-based-apps).

A modern evolution of Backend for Frontend is used, called the [Token Handler Pattern](https://curity.io/resources/learn/the-token-handler-pattern/).\
The SPA uses an OAuth Agent to perform an API driven OpenID Connect flow:

![Logical Components](images/logical-components.png)

## Architecture Benefits

This provides the best separation of web and API concerns, to maintain all of the benefits of an SPA architecture:

- `Strongest Browser Security` developed by experts, with only SameSite=strict cookies in the browser
- `Supported Solution`, with design guidance and professional services support
- `Great User Experience` due to the separation of web and API concerns
- `Productive Developer Experience` with only simple security code needed in the SPA
- `Deploy Anywhere`, such as to a Content Delivery Network

## Simple Code in Apps

This repository demonstrates the business focused components you should need to develop:

- A Single Page App coded in React
- A Web Host to provide static content
- An API that validates JWT access tokens

It also provides an example deployment so that you can understand the moving parts.

## Run the End-to-end Flow

The SPA can be quickly run in an end-to-end flow on a development computer by following this guide:

- [Deployment Instructions](/DEPLOYMENT.md)

## Website Documentation

See the following resources for further information and tutorials:

- [Curity Token Handler Product](https://curity.io/product/token-handler/)
- [Create a Token Handler](https://curity.io/resources/learn/curity-token-handler/)
- [SPA Code Example](https://curity.io/resources/learn/token-handler-spa-example/)
- [Deployment Tutorial](https://curity.io/resources/learn/token-handler-deployment-example/)

## More Information

Please visit [curity.io](https://curity.io/) for more information about the Curity Identity Server.


