$messageParameters = @{                        
    From = "test@domain.com"
    To = "my@email.com"

    Subject = "test"
    Body = "test"
    SmtpServer = "IP.Add.re.ss"
}                        
Send-MailMessage @messageParameters -BodyAsHtml
