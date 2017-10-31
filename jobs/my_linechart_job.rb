require 'nokogiri'
require 'open-uri'
current_valuation = 0

labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July']

SCHEDULER.every '10s' do
  doc = Nokogiri::HTML(open("http://www.cpcb.gov.in/caaqm/frmCurrentDataNew.aspx?StationName=Sidhu%20Kanhu%20Indoor%20Stadium&StateId=29&CityId=552"))
  el = doc.xpath("//td[@id='Td1']").first
  table = el.css('table')
  c = table.css('tr')
  c1 = c.css('td[4]')



  last_valuation = current_valuation
  haha = c1[2].text
  current_valuation = haha.to_f
  data = [
    {
      label: 'First dataset',
      data: Array.new(labels.length) { current_valuation },
      backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * labels.length,
      borderColor: [ 'rgba(255, 99, 132, 1)' ] * labels.length,
      borderWidth: 1,
    }
  ]

  send_event('linechart', { labels: labels, datasets: data })
end
