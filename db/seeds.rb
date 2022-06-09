# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@rei = Merchant.create!(name: "REI")

@discount_1 = @rei.discounts.create!(percentage: 20, threshold: 2)
@discount_2 = @rei.discounts.create!(percentage: 35, threshold: 3)
@discount_3 = @rei.discounts.create!(percentage: 50, threshold: 4)
