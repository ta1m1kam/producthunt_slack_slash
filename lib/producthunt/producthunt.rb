# frozen_string_literal: true

require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require_relative './product'

BASE_URL = 'https://www.producthunt.com/'

class ProductHunt
  def setup_doc(url)
    charset = 'utf-8'
    html = open(url) { |f| f.read }
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.search('br').each { |n| n.replace("\n") }
    doc
  end

  def product_docs(url)
    doc = setup_doc(url)
    product_docs = doc.css('div.container_88f8e').css('li div.item_54fdd')
    product_docs
  end

  def scrape(doc)
    name = doc.css('h3').text
    description = doc.css('p').text
    category = doc.css('span.font_9d927.grey_bbe43').text
    detail_url = 'https://www.producthunt.com' + doc.css('a.link_523b9').attribute('href').value
    product = Product.new(name, description,category, detail_url)
    product
  end

  def producthunts
    product_docs = product_docs(BASE_URL)
    products = []
    product_docs.each do |doc|
      product = scrape(doc)
      next if product.category.empty?
      products << scrape(doc)
    end
    products
  end
end

