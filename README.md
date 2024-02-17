# DWTest

## Architecture
### MVP (Model-View-Presenter)
Our implementation of the MVP pattern organizes the codebase into three core components, each with distinct responsibilities:
- **Models**: Handle data logic and business rules. They interact with the network layer to fetch, store, and manipulate data.
- **Views**: UI elements that present data to the user. Views notify the Presenter about user actions but do not directly respond to those actions.
- **Presenters**: Serve as an intermediary between Models and Views, fetching data from Models, and preparing it for presentation by the Views.

### Directory Structure
The project's directory is organized as follows to align with the MVP architecture:
```
/DWTest
    /Models
    /Views
    /Presenters
    /NetworkLayer
```

## Getting Started
To set up the project locally, follow these steps:
```bash
git clone https://github.com/deniswindover/DWTest.git
cd projectname
# Instructions to install dependencies
# Any additional setup
```
