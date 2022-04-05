*** Settings ***
Documentation             UI User can register through web portal
Library                   SeleniumLibrary
Resource                  demo_keywords.robot
Suite Teardown            Close All Browsers

*** Test Cases ***
Register on web portal
    [Tags]    Test1
    Navigate to Login page
    Wait for homepage to load and click on Register
    Enter a desired username
    Enter New User Password
    Enter First Name
    Enter Family Name
    Enter Phone number
    Click on Register
    Assert registeration success


# robot -d TestReports register.robot
