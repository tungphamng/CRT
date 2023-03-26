*** Settings ***
Resource                      common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Variables ***
${Salutation}
${firstName}
${lastName}
${fullTitle}
${fullName}

*** Test Cases ***
Entering A Lead
    [tags]                    Lead    testgen    nwise=2    numtests=9
    Appstate                  Home
    LaunchApp                 Sales

    ClickText                 Leads
    ClickText                 New                         anchor=Import            timeout=120s
    VerifyText                Lead Information
    UseModal                  On                          # Only find fields from open modal dialog

    ${Salutation}=            Convert To String           [Ms.,Mrs.,Mr.]
    ${firstName}=             Convert To String           [Tina,Jessica,John]
    ${lastName}=              Convert To String           [Smith,Thomas,Theodore]
    ${fullTitle}=             Catenate                    ${Salutation}               ${firstName}    ${lastName}
    ${fullName}=              Catenate                    ${firstName}                ${lastName}

    Picklist                  Salutation                  ${Salutation}
    TypeText                  First Name                  ${firstName}
    TypeText                  Last Name                   ${lastName}
    Picklist                  Lead Status                 New
    TypeText                  Phone                       +12234567858449             First Name
    TypeText                  Company                     Growmore                    Last Name
    TypeText                  Title                       Manager                     Address Information
    TypeText                  Email                       VALID_EMAIL_ADDRESS         Rating
    TypeText                  Website                     https://www.growmore.com/

    Picklist                  Lead Source                 Partner
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    ClickText                 Details                     anchor=Chatter              timeout=40s
    VerifyField               Name                        ${fullTitle}
    VerifyField               Lead Status                 New
    VerifyField               Phone                       +12234567858449
    VerifyField               Company                     Growmore
    VerifyField               Website                     https://www.growmore.com/

    # as an example, let's check Phone number format. Should be "+" and 14 numbers
    ${phone_num}=             GetFieldValue               Phone
    Should Match Regexp	      ${phone_num}	              ^[+]\\d{14}$
    
    ClickText                 Leads
    VerifyText                ${fullName}
    VerifyText                Manager
    VerifyText                Growmore

    #Delete the generated Leads for cleanup
    LaunchApp                 Sales
    ClickText                 Leads
    Sleep                     1

    ClickText                    ${fullName}    timeout=3
    ClickText                    Show more actions
    ClickText                    Delete
    ClickText                    Delete
    ClickText                    Close
