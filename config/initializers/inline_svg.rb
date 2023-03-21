InlineSvg.configure do |config|
  config.asset_file = InlineSvg::CachedAssetFile.new(
    paths: [
      Rails.root.join("public"),
    ],
    filters: /\.svg/
  )
end
