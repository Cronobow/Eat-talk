# Default Category

Category.destroy_all

category_list = [
  { name: "中式料理" },
  { name: "日本料理" },
  { name: "義大利料理" },
  { name: "墨西哥料理" },
  { name: "素食料理" },
  { name: "美式料理" },
  { name: "複合式料理" }
]

category_list.each do |c|
  Category.create(name: c[:name])
end

puts "Category created!"

# Default admin

User.create(email: "max@max.com", password: "000000", role: "admin")

puts "Default admin created!"
