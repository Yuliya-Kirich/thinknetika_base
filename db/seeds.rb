# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = Category.create([
                               { type_of_category: 'Junior', number: 1 },
                               { type_of_category: 'Middle', number: 2 },
                               { type_of_category: 'Master', number: 3 },
                               { type_of_category: 'Guru', number: 4 },
                               { type_of_category: 'No Category', number: 0 }
                             ])

# Create users
users = User.create([
                      { first_name: 'liya', last_name: 'Mirich', email: 'yvkirich@gmail.com' },
                      { first_name: 'Yuliya', last_name: 'Kirichenko', email: 'iu31101987@yandex.ru' },
                      { first_name: 'Mariya', last_name: 'Pronina', email: 'y.kirichenko@revo.ru' },
                      { first_name: 'Mar', last_name: 'Pro', email: 'tsyganova.yv@gmail.com' }
                    ])

# Create tests
tests = Test.create([
                      { title: 'Test01', level: 6, category: categories[0], author: users[0] },
                      { title: 'Test02', level: 2, category: categories[3], author: users[1] },
                      { title: 'Test03', level: 1, category: categories[4], author: users[2] },
                      { title: 'Test04', level: 6, category: categories[4], author: users[3] }
                    ])

# Create questions
questions = Question.create([
                              { body: 'Question Test 1', test: tests[0] },
                              { body: 'Question Test 2', test: tests[2] }
                            ])

# Create answers
Answer.create([
                { body: 'Test answer', question: questions[0] },
                { body: 'Test answer', question: questions[1] }
              ])

# TestPassage.create([{user_id: user[0].id, test_id: test[0].id, current_question_id: current_question[0].id},
#                     {user_id: user[1].id, test_id: test[3].id, current_question_id: current_question[0].id},
#                  {user_id: user[0].id, test_id: test[3].id, current_question_id: current_question[0].id}])
