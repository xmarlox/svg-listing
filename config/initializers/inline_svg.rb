InlineSvg.configure do |config|
  config.asset_file = InlineSvg::CachedAssetFile.new(
    paths: [
      Rails.root.join("public"),
      Rails.root.join("storage"),
    ],
    filters: /\.svg/
  )
end
