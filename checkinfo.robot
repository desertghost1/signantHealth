*** Settings ***
Documentation             User can review own information on web portal
Library                   SeleniumLibrary
Resource                  demo_keywords.robot
Suite Setup               Navigate to Login page
Suite Teardown            Close All Browsers

*** Test Cases ***
Review own info
    [Tags]    Test2
    Setup new account for checkinfo.robot test
    Wait for homepage to load and click on Log In
    Enter valid login credentials to view info
    Review and Assert own user info



# robot -d TestReports checkinfo.robot