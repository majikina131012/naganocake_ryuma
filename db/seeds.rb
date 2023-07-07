# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: "ryuma@1012",
    password: "111111"
    )

Genre.create!(
    name: "ケーキ"
    )

# Item.create!(
#     name: "チョコケーキ",
#     description: "チョコたっぷり！",
#     price_without_tax: "2000",
#     genre_id: 1,
#     is_active: true
#     )

# 画像ファイルのパスを指定
image_path = Rails.root.join('app', 'assets', 'images', 'chocolate_cake.jpg')

# 画像ファイルを一時的にオープン
image_file = File.open(image_path)

# Itemを作成し、画像をActive Storageに登録
item = Item.create!(
  name: "チョコケーキ",
  description: "チョコたっぷり！",
  price_without_tax: "2000",
  genre_id: 1,
  is_active: true
)

# 画像ファイルをアタッチ
item.item_image.attach(io: image_file, filename: 'chocolate_cake.jpg')

# 画像ファイルをクローズ
image_file.close
