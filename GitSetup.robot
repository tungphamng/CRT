*** Settings ***
Resource                        common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime

*** Variables ***
${unique_name}    


*** Test Cases ***
Entering A Lead
    [tags]                      Lead                 Git Repo Exercise
    Appstate                    Home
    LaunchApp                   Sales

    ClickText                   Leads
    VerifyText                  Recently Viewed      timeout=120s
    ClickText                   New                  anchor=Import
    VerifyText                  Lead Information
    UseModal                    On                   # Only find fields from open modal dialog

    Picklist                    Salutation           Ms.
    TypeText                    First Name           Tina
    TypeText                    Last Name            Smith
    Picklist                    Lead Status          Working
    TypeText                    Phone                +12234567858449             First Name
    TypeText                    Company              Growmore                    Last Name
    TypeText                    Title                Manager                     Address Information
    TypeText                    Email                tina.smith@gmail.com        Rating
    TypeText                    Website              https://www.growmore.com/

    ClickText                   Lead Source
    ClickText                   Advertisement
    ClickText                   Save                 partial_match=False
    UseModal                    Off
    Sleep                       2

    ClickText                   Details              anchor=Chatter
    VerifyText                  Ms. Tina Smith
    VerifyText                  Manager              anchor=Title
    VerifyField                 Phone                +12234567858449
    VerifyField                 Company              Growmore
    VerifyField                 Website              https://www.growmore.com/

    ClickText                   Leads
    VerifyText                  Tina Smith
    VerifyText                  Manager
    VerifyText                  Growmore

Delete Tina Smith's Lead
    [tags]                      Lead                 Git Repo Exercise
    LaunchApp                   Sales
    ClickText                   Leads
    VerifyText                  Recently Viewed      timeout=120s

    Wait Until Keyword Succeeds                      1 min                       5 sec                  ClickText     Tina Smith
    ClickText                   Show more actions
    ClickText                   Delete
    ClickText                   Delete
    ClickText                   Close
