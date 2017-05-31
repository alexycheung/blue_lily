class ZillowService
	def self.get_property(zillow_url)
		if zillow_url && zillow_url.match(/zillow.com/)
			response = HTTParty.get(zillow_url)
			if response.code == 200
				html = response.body
				address = html.match(/<span itemprop="streetAddress">([^*]+?)</)[1].strip()
				city = html.match(/<span itemprop="addressLocality">([^*]+?)</)[1].strip()
				state = html.match(/<span itemprop="addressRegion">([^*]+?)</)[1].strip()
				zip = html.match(/<span itemprop="postalCode"[^*]+?">([^*]+?)</)[1].strip()
				bedrooms = html.match(/<span class="addr_bbs">((?<!\.)\d+(?!\.)) beds</)[1].strip().to_i
				bathrooms = html.match(/<span class="addr_bbs">((?<!\.)\d+(?!\.)) baths</)[1].strip().to_i
				sqft = html.match(/id="sqft"[^*]+?value="([^*]+?)"/)[1].strip().gsub(",","").to_i

				property = {
					zillow_url: zillow_url,
					address: address,
					city: city,
					state: state,
					zip: zip,
					bedrooms: bedrooms,
					bathrooms: bathrooms,
					sqft: sqft,
				}
				return property
			end
		end
		return nil
	end
end