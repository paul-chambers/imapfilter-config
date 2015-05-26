options.namespace = false
options.info = true

dofile('account.lua')

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function filtermail(msgs)

	-- print("start "..tablelength(msgs))

	career = msgs:contain_to('resume@bod.org')
		 + msgs:contain_from('linkedin.com')

	career:move_messages(gmail.Career)

	msgs = msgs - career

	-- print("career "..tablelength(msgs))

	crowdfunding = msgs:contain_from('indiegogo.com')
			+ msgs:contain_from('kickstarter.com')
			+ msgs:contain_from('backerclub.co')

	crowdfunding:move_messages(gmail.CrowdFunding)

	msgs = msgs - crowdfunding

	-- print("crowdfunding "..tablelength(msgs))

	finance = msgs:contain_from('wellsfargo.com')
		+ msgs:contain_from('chase.com')
		+ msgs:contain_from('citibank.com')
		+ msgs:contain_from('paypal.com')
		+ msgs:contain_from('akimbocard.com')
		+ msgs:contain_from('personalcapital.com')
		+ msgs:contain_from('mint.com')
		+ msgs:contain_from('paytrust.com')

	finance:move_messages(gmail.Finance)

	msgs = msgs - finance

	-- print("finance "..tablelength(msgs))

	hosting = msgs:contain_from('dreamhost.com')
		+ msgs:contain_from('dreamhostregistry.com')
		+ msgs:contain_from('ramnode.com')
		+ msgs:contain_from('weloveservers.net')
		+ msgs:contain_from('chicagovps.com')
		+ msgs:contain_from('opendns.com')
		+ msgs:contain_from('dnsomatic.com')
		+ msgs:contain_from('enom.com')
		+ msgs:contain_from('domaindiscount24.com')

	hosting:move_messages(gmail.Hosting)

	msgs = msgs - hosting

	-- print("hosting "..tablelength(msgs))

	shipping = msgs:contain_subject('shipped')
		+ msgs:contain_from('shipping')
		+ msgs:contain_from('shipment')
		+ msgs:contain_from('ship-confirm@amazon.com')
		+ msgs:contain_from('ups.com')
		+ msgs:contain_from('fedex.com')

	shipping:move_messages(gmail.Shipping)

	msgs = msgs - shipping

	-- print("shipping "..tablelength(msgs))

	social = msgs:contain_from('twitter.com')
		+ msgs:contain_from('facebook.com')
		+ msgs:contain_from('foursquare.com')
		+ msgs:contain_from('meetup.com')
		+ msgs:contain_from('nextdoor.com')
		+ msgs:contain_from('yelp.com')
		+ msgs:contain_from('youtube.com')

	social:move_messages(gmail.Social)

	msgs = msgs - social

	-- print("social "..tablelength(msgs))

	travel = msgs:contain_from('travelocity.com')
		+ msgs:contain_from('expedia.com')
		+ msgs:contain_from('orbitz.com')
		+ msgs:contain_from('kayak.com')
		+ msgs:contain_from('jetsetter.com')
		+ msgs:contain_from('marriott-email.com')
		+ msgs:contain_from('hilton.com')
		+ msgs:contain_from('carlsonhotels.com')
		+ msgs:contain_from('bestwestern.com')
		+ msgs:contain_from('lufthansa.com')
		+ msgs:contain_from('milesandmore.com')
		+ msgs:contain_from('virginamerica.com')
		+ msgs:contain_from('delta.com')
		+ msgs:contain_from('tripadvisor.com')
		+ msgs:contain_from('tripit.com')

	travel:move_messages(gmail.Travel)

	msgs = msgs - travel

	-- print("travel "..tablelength(msgs))

	bulk = msgs:contain_from('noreply')
		+ msgs:contain_from('no-reply')
		+ msgs:contain_from('no_reply')
		+ msgs:contain_from('do-not-reply')
		+ msgs:contain_from('news')
		+ msgs:contain_from('newsletter')
		+ msgs:contain_from('deals')
		+ msgs:contain_from('outlet')
		+ msgs:contain_from('warehouse')
		+ msgs:contain_from('sales')
		+ msgs:contain_from('info')
		+ msgs:contain_from('service@')
		+ msgs:contain_from('support@')
		+ msgs:contain_from('promo')
		+ msgs:contain_from('livingsocial.com')
		+ msgs:contain_from('groupon.com')
		+ msgs:contain_from('localdeals@amazon.com')
		+ msgs:contain_from('costco.com')

	bulk:move_messages(gmail.Bulk)

	msgs = msgs - bulk

	-- print("bulk "..tablelength(msgs))

	msgs:move_messages(gmail.INBOX)
end

function checkmail()

    -- use pcall to catch errors, and just keep going

    while not pcall (
	function () 
	    repeat
		msgs = gmail.prefilter:select_all()
		filtermail(msgs)
	    until gmail.prefilter:enter_idle()
	end
    ) do
	-- loop on error. otherwise drop through (e.g. if IDLE not supported)
    end
end


become_daemon( 60, checkmail )
