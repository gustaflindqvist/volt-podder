require 'json'
require 'net/http'
require 'nokogiri'

toppodcasts_urls = [
  'https://itunes.apple.com/se/rss/toppodcasts/limit=5/json',
  #'https://itunes.apple.com/en/rss/toppodcasts/limit=5/json'
]

toppodcasts_urls.each do |url|
  resp = Net::HTTP.get_response(URI.parse(url))
  data = resp.body
  result = JSON.parse(data)
  p result["feed"]["entry"][0]
  result["feed"]["entry"].each do |pod|
    current_link_id = pod["id"]["attributes"]["im:id"]
    current_pod = {
      title: pod["im:name"]["label"],
      releaseDate: pod["im:releaseDate"]["label"],
      description: pod["summary"]["label"],
      copy: pod["rights"].nil? ? '' : pod["rights"]["label"] ,
      link_id: current_link_id,
      imageUrl: pod["im:image"][2]["label"]
    } unless pod["im:name"]["label"].nil?

    current_podcast_url = "https://itunes.apple.com/lookup?id=#{current_link_id}&entity=podcast"
    resp1 = Net::HTTP.get_response(URI.parse(current_podcast_url))
    data1 = resp1.body
    result1 = JSON.parse(data1)
    result1["results"].each do |entry|
      p entry
      current_pod.merge!({
        feedUrl: entry["feedUrl"],
        genre: entry["primaryGenreName"]
      })

      p entry["feedUrl"]
      p URI.parse(entry["feedUrl"])
      resp1 = Net::HTTP.get_response(URI.parse(entry["feedUrl"]))
      doc = Nokogiri::XML(resp1.body)
      doc.xpath('//channel/item').each do |n|
        puts n
        $page.store._medias << {
          podcast_id: current_link_id,
          title: n.xpath('title').text,
          pubDate: n.xpath('pubDate').text,
          url: n.xpath('link').text
        }
      end
    end
    $page.store._podcasts << current_pod
  end
end
