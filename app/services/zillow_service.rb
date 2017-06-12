class ZillowService
	def self.get_property(zillow_url)
		if zillow_url && zillow_url.match(/zillow.com/)
			property = nil
			attempts = 0

			until property || attempts > 5
				attempts += 1
				response = HTTParty.get(zillow_url)
				html = response.body

				if html.match(/addr_bbs">(\d+\.?\d*) bed/) &&
					 html.match(/addr_bbs">(\d+\.?\d*) bath/)
					address = html.match(/"streetAddress">([^*]+?)</)[1].strip()
					city = html.match(/<span itemprop="addressLocality">([^*]+?)</)[1].strip()
					state = html.match(/<span itemprop="addressRegion">([^*]+?)</)[1].strip()
					zip = html.match(/<span itemprop="postalCode"[^*]+?">([^*]+?)</)[1].strip()
					bedrooms = html.match(/addr_bbs">(\d+\.?\d*) bed/)[1].strip().to_f
					bathrooms = html.match(/addr_bbs">(\d+\.?\d*) bath/)[1].strip().to_f
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
		end
		return nil
	end
end