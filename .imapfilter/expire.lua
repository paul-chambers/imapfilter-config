dofile( 'account.lua' )

-- move bulk emails older than a week out of the inbox

-- expiring = gmail.INBOX:is_older(7) * gmail.Bulk:is_older(7)
expiring = gmail.Bulk:is_older(7)

gmail.INBOX:move_messages(gmail.Bulk,expiring)

-- expire 'perishable' emails

gmail['Expire/Year' ]:delete_messages(gmail['Expire/Year' ]:is_older(365))
gmail['Expire/Month']:delete_messages(gmail['Expire/Month']:is_older(31))
gmail['Expire/Week' ]:delete_messages(gmail['Expire/Week' ]:is_older(7))
