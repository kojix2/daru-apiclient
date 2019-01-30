# 🔶 Daru::APIClient 🔶


## 🔸Overview🔸
Get JSON data from Rest API with [httparty](https://github.com/jnunemaker/httparty) and create Daru::DataFrame. 

## 🔸Installation🔸

```bash
gem install daru-apiclient
```

## 🔸Requirements🔸

* Ruby
* Daru
* httparty
* Jupyter notebook with IRuby (reccomended)

## 🔸Examples🔸
Get [BestGems.org](http://bestgems.org/)'s data using API.
![alt text](https://raw.githubusercontent.com/kojix2/daru-apiclient/master/notebook/daru-apiclient.png)
```bash
juypter notebook
```

```ruby
require 'daru/apiclient'
require 'daru/view'
Daru::View.plotting_library = :googlecharts

C = Daru::APIClient.new "http://bestgems.org/api/v1/gems"

def bestgems(gem)
  df = C.get("/#{gem}/daily_downloads.json")
  df.rename_vectors "daily_downloads" => gem
  df
end

rack = bestgems "rack"
rake = bestgems "rake"
json = bestgems "json"
thor = bestgems "thor"

df = rack.join(rake, how: :inner, on: ["date"])
         .join(json, how: :inner, on: ["date"])
         .join(thor, how: :inner, on: ["date"])

df.order = ["date", "rack", "rake", "json", "thor"]
df.sort!(["date"])
df = df.row[-300..-20]

chart = Daru::View::Plot.new(df,
  type: :area,
  isStacked: true,
  height: 400
  )
chart.show_in_iruby
```

## 🔸Development🔸
* This gem will keeps its simplicity.

## 🔸Contributing🔸

Bug reports and pull requests are welcome on GitHub at https://github.com/kojix2/daru-apiclient.

## 🔸License🔸

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
