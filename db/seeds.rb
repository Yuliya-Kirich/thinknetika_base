# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
category = Category.create([{type_category: 'Junior', number: 1},
                            {type_category: 'Middle', number: 2},
                            {type_category: 'Master', number: 3},
                            {type_category: 'Guru', number: 4},
                            {type_category: 'No Category', number: 0}])
test = Test.create([{title: 'Test01', level: 6, category_id: 1},
                    { title: 'Test02', level: 2, category_id: 4 },
                    { title: 'Test03', level: 1, category_id: 5 }])

question = Question.create([{body: 'Question Test 1', test_id: 1},
                            {body: 'Question Test 2', test_id: 3}])
user = User.create([{first_name: 'Yuliya', last_name: 'Kirichenko', test_id: 1},
                    {first_name: 'Yuliya', last_name: 'Kirichenko', test_id: 3}])
answer = Answer.create([{body: 'Test answer', question_id: 1},
                        {body: 'Test answer', question_id: 2}])
