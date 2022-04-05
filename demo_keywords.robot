*** Settings ***
Documentation    Keywords for Demo App tests
Library          SeleniumLibrary
Library          FakerLibrary
Resource         demo_variables.robot


*** Keywords ***
Navigate to Login page
    open browser                                           ${URL}                             ${BROWSER}

Wait for homepage to load and click on Register
     wait until element is enabled                         ${HOMEPAGE_REGISTER_BUTTON}        10s
     click element                                         ${HOMEPAGE_REGISTER_BUTTON}

Wait for homepage to load and click on Log In
     wait until element is enabled                         ${LOGIN}                           10s
     click element                                         ${LOGIN}


#keywords to register new user
Enter a desired username
     ${email}=                                             FakerLibrary.email
     log                                                   ${email}
     set Test variable                                     ${email}

     wait until element is enabled                         ${USERNAME_FIELD}                 10s
     input text                                            ${USERNAME_FIELD}                 ${email}


Enter New User Password
    #[Arguments]                                           ${password}
    input password                                         ${PASSWORD_FIELD}            Technicaltest     #${password}


Enter First Name
    ${FirstName}=                                          FakerLibrary.First Name Female
    log                                                    ${FirstName}
    Set Test Variable                                      ${FirstName}
    input text                                             ${FIRSTNAME_FIELD}                ${First_name}


Enter Family Name
    ${LastName}=                                           FakerLibrary.Last Name
    log                                                    ${LastName}
    Set Test Variable                                      ${LastName}
    input text                                             ${FAMILYNAME_FIELD}               ${Last_name}


Enter Phone number
    input text                                             ${PHONENUMBER_FIELD}              123456789

Click on Register
    click element                                          ${REGISTER}

Assert registeration success
    wait until element is visible                          ${SECTION_HEADER_LOGIN}           10s





#keywords to 'register new user' and check user info

Setup new account for checkinfo.robot test
     Wait for homepage to load and click on Register
     wait until element is enabled                         ${USERNAME_FIELD}                 10s
     input text                                            ${USERNAME_FIELD}                 qaengineer
     input text                                            ${PASSWORD_FIELD}                 testing
     input text                                            ${FIRSTNAME_FIELD}                QA
     input text                                            ${FAMILYNAME_FIELD}               Engineer
     input text                                            ${PHONENUMBER_FIELD}              987654321
     click element                                         ${REGISTER}

Enter valid login credentials to view info
     wait until element is enabled                         ${USERNAME_FIELD}                 10s
     input text                                            ${USERNAME_FIELD}                 qaengineer
     input text                                            ${PASSWORD_FIELD}                 testing
     click element                                         ${SECTION_HEADER_LOGIN_BUTTON}

Review and Assert own user info
     page should contain                                   qaengineer
     page should contain                                   QA
     page should contain                                   Engineer
     page should contain                                   987654321


