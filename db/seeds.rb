# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



category = Category.create([{type_of_category: 'Junior', number: 1},
                            {type_of_category: 'Middle', number: 2},
                            {type_of_category: 'Master', number: 3},
                            {type_of_category: 'Guru', number: 4},
                            {type_of_category: 'No Category', number: 0}])
user = User.create([{first_name: 'liya', last_name: 'Mirich'},
                    {first_name: 'Yuliya', last_name: 'Kirichenko'},
                    {first_name: 'Mariya', last_name: 'Pronina'},
                    {first_name: 'Mar', last_name: 'Pro'}])

test = Test.create([{title: 'Test01', level: 6, category_id: category[0].id, author: user[0]},
                    {title: 'Test02', level: 2, category_id: category[3].id, author: user[1]},
                    {title: 'Test03', level: 1, category_id: category[4].id, author: user[2]},
                    {title: 'Test04', level: 6, category_id: category[4].id, author: user[3]}])

question = Question.create([{body: 'Question Test 1', test_id: test[0].id},
                            {body: 'Question Test 2', test_id: test[2].id}])

Answer.create([{body: 'Test answer', question_id: question[0].id},
               {body: 'Test answer', question_id: question[1].id}])
UsersSession.create([{user_id: user[0].id, test_id: test[0].id},
                     {user_id: user[1].id, test_id: test[3].id},
                     {user_id: user[0].id, test_id: test[3].id}])

