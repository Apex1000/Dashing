require 'nokogiri'
require 'open-uri'
current_valuation = 0
current_valuation1 = 0
current_valuation2 = 0
current_valuation3 = 0
current_valuation4 = 0

SCHEDULER.every '2s' do
  doc = Nokogiri::HTML(open("http://www.cpcb.gov.in/caaqm/frmCurrentDataNew.aspx?StationName=Sidhu%20Kanhu%20Indoor%20Stadium&StateId=29&CityId=552"))
  el = doc.xpath("//td[@id='Td1']").first
  table = el.css('table')
  c = table.css('tr')
  c1 = c.css('td[4]')



  last_valuation = current_valuation
  haha = c1[2].text
  current_valuation = haha.to_f
  send_event('valuation', { current: current_valuation, last: last_valuation })

  last_valuation1 = current_valuation1
  haha1 = c1[3].text
  current_valuation1 = haha1.to_f
  send_event('valuation1', { current: current_valuation1, last: last_valuation1 })

  last_valuation2 = current_valuation2
  haha2 = c1[4].text
  current_valuation2 = haha2.to_f
  send_event('valuation2', { current: current_valuation2, last: last_valuation2 })

  last_valuation3 = current_valuation3
  haha3 = c1[5].text
  current_valuation3 = haha3.to_f
  send_event('valuation3', { current: current_valuation3, last: last_valuation3 })

  last_valuation4 = current_valuation4
  haha4 = c1[6].text
  current_valuation4 = haha4.to_f
  send_event('valuation4', { current: current_valuation4, last: last_valuation4 })


  haha5 = c1[1].text
  ha5 = haha5.to_f
  send_event('synergy',   { value: ha5 })
end