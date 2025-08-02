# Notes

## Archetectural Decisions

I decided to go with a single view to keep the UI simple. This way you can see
all of the expenses and categories in one place, and see updates in real time.
If I were to build this out more, I would probably add more views so that
additional details about categories and expenses could be viewed.

## Shortcuts

I only added in create and read functionality and avoided update and delete. I
also utilized AI to help generate tests.

## Handling Currency

For handling the currency aspects of the App, I used the `Decimal` type and
module. This is a good choice for handling currency because it avoids the
precision issues that can arise with floating point numbers.
