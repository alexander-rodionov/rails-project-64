
categories = [
  { name: "Кино" },
  { name: "Спектакли" }
].map do |i|
  Category.create(i)
end


users = [
  {
    email: 'johndoe@mail.cc',
    password: 123456,
    encrypted_password: User.new.send(:password_digest, '123456')
  } ].map do |u|
  User.create(u)
end

posts = [
  {
    title: 'Минцифры отчиталось о полном импортозамещении компьютерных вирусов',
    category: categories[0],
    body: "Министерство цифрового развития, связи и массовых коммуникаций РФ отчиталось о полном импортозамещении компьютерных вирусов. Согласно докладу, представленному на заседании правительства, российские вредоносные программы полностью вытеснили зарубежные аналоги с отечественного рынка.
«Мы с гордостью заявляем, что теперь российские компьютеры заражаются исключительно отечественными вирусами, – сообщил министр цифрового развития Максут Шадаев. – Наши программисты создали целую линейку импортонезависимых вредоносных программ – от простейших троянов до продвинутых шифровальщиков с искусственным интеллектом и патриотическим интерфейсом».
Отдельно министр отметил вирус «Матрёшка-3000», который научился не только обнаруживать все операции с криптовалютой, но и переводить средства на счета Центробанка.
«Иногда по ошибке вирус переводит рубли вместо биткоинов, но и они отечественной экономике не помешают», – уточнил глава Минцифры.
Лучших разработчиков отечественных вредоносных программ наградят почётными грамотами, а некоторым из них 1 мая в Кремля присвоят звание Героя Труда.",
    user: users[0],
    status: 'published'
  },
  {
    title: 'Государство будет самостоятельно устанавливать зарплаты айтишников, исходя из независимого тестирования',
    category: categories[1],
    body: "Правительство готовит постановление о системе независимой государственной оценки компетенций IT-специалистов. Именно исходя из результатов теста будут устанавливаться зарплаты для таких сотрудников.
Подтверждать квалификацию и компетенции айтишникам предстоит на тестировании, напоминающем единый государственный экзамен. Те, кто наберут недостаточно баллов, вообще не смогут работать в IT, а для остальных система установит уровень рекомендованной зарплаты.
«Работодателям запретят платить сотруднику больше, чем рекомендовано системой... В том числе в виде премий, в том числе в виде годовых премий. Это будет контролироваться, – рассказали в Минцифры. – Такой шаг позволит восстановить социальную справедливость и исключить случаи, когда у нас врачи и учителя получают существенно меньше IT-специалистов».
Этот функционал, как считают эксперты правительства, поможет сдержать рост зарплат айтишников и тем самым «более справедливо распределять ресурсы в масштабах компаний и государства». Вдобавок таким образом будет устранена главная причина инфляции в отечественной экономике.",
    user: users[0],
    status: 'published'
  }
]
.map do |p|
  Post.create(p)
end

root_post = posts[1]
author = users[0]
comment_1 = PostComment.create({ parent: nil, content: 'level 1 comment 1', user: author, post: root_post })
comment_2 = PostComment.create({ parent: comment_1, content: 'level 2 comment', user: author, post: root_post })
comment_4 = PostComment.create({ parent: comment_2, content: 'level 3 comment', user: author, post: root_post })
comment_3 = PostComment.create({ parent: nil, content: 'level 1 comment 2', user: author, post: root_post })
