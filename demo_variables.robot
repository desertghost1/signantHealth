*** Variables ***

#homepage locators
${URL}                               http://192.168.1.121:8080/
${BROWSER}                           chrome     #firefox
${HOMEPAGE_REGISTER_BUTTON}          xpath:/html/body/nav/ul/li[1]/a
${LOGIN}                             xpath:/html/body/nav/ul/li[2]/a


#register new user locators
${USERNAME_FIELD}                    id:username
${PASSWORD_FIELD}                    id:password
${FIRSTNAME_FIELD}                   id:firstname
${FAMILYNAME_FIELD}                  id:lastname
${PHONENUMBER_FIELD}                 id:phone
${REGISTER}                          xpath:/html/body/section/form/input[6]


#signin locators
${LOGINPAGE_USERNAME}                id:username
${LOGINPAGE_PASSWORD}                id:password
${LOGINPAGE_LOGINBUTTON}             xpath:/html/body/section/form


#section header locator for assertion
${SECTION_HEADER_LOGIN}              xpath:/html/body/section/header/h1
${SECTION_HEADER_LOGIN_BUTTON}       xpath:/html/body/section/form/input[3]





