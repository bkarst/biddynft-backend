require 'test_helper'

class NftListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nft_listing = nft_listings(:one)
  end

  test "should get index" do
    get nft_listings_url
    assert_response :success
  end

  test "should get new" do
    get new_nft_listing_url
    assert_response :success
  end

  test "should create nft_listing" do
    assert_difference('NftListing.count') do
      post nft_listings_url, params: { nft_listing: { auction_end_time: @nft_listing.auction_end_time, auction_start_time: @nft_listing.auction_start_time, author_image_url: @nft_listing.author_image_url, image_url: @nft_listing.image_url, listing_type: @nft_listing.listing_type, minimum_bid: @nft_listing.minimum_bid, price: @nft_listing.price, reserve_price: @nft_listing.reserve_price, title: @nft_listing.title } }
    end

    assert_redirected_to nft_listing_url(NftListing.last)
  end

  test "should show nft_listing" do
    get nft_listing_url(@nft_listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_nft_listing_url(@nft_listing)
    assert_response :success
  end

  test "should update nft_listing" do
    patch nft_listing_url(@nft_listing), params: { nft_listing: { auction_end_time: @nft_listing.auction_end_time, auction_start_time: @nft_listing.auction_start_time, author_image_url: @nft_listing.author_image_url, image_url: @nft_listing.image_url, listing_type: @nft_listing.listing_type, minimum_bid: @nft_listing.minimum_bid, price: @nft_listing.price, reserve_price: @nft_listing.reserve_price, title: @nft_listing.title } }
    assert_redirected_to nft_listing_url(@nft_listing)
  end

  test "should destroy nft_listing" do
    assert_difference('NftListing.count', -1) do
      delete nft_listing_url(@nft_listing)
    end

    assert_redirected_to nft_listings_url
  end
end
