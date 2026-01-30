import Foundation

class LessonDataService {
    static let shared = LessonDataService()

    private init() {}

    // MARK: - Fixed Lesson IDs
    // CRITICAL: These UUIDs must NEVER change to ensure lesson progress persists correctly
    private enum LessonID {
        static let lesson01 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000001")!
        static let lesson02 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000002")!
        static let lesson03 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000003")!
        static let lesson04 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000004")!
        static let lesson05 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000005")!
        static let lesson06 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000006")!
        static let lesson07 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000007")!
        static let lesson08 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000008")!
        static let lesson09 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000009")!
        static let lesson10 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000010")!
        static let lesson11 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000011")!
        static let lesson12 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000012")!
        static let lesson13 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000013")!
        static let lesson14 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000014")!
        static let lesson15 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000015")!
        static let lesson16 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000016")!
        static let lesson17 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000017")!
        static let lesson18 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000018")!
        static let lesson19 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000019")!
        static let lesson20 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000020")!
        static let lesson21 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000021")!
        static let lesson22 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000022")!
        static let lesson23 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000023")!
        static let lesson24 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000024")!
        static let lesson25 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000025")!
        static let lesson26 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000026")!
        static let lesson27 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000027")!
        static let lesson28 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000028")!
        static let lesson29 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000029")!
        static let lesson30 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000030")!
        static let lesson31 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000031")!
        static let lesson32 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000032")!
        static let lesson33 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000033")!
        static let lesson34 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000034")!
        static let lesson35 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000035")!
        static let lesson36 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000036")!
        static let lesson37 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000037")!
        static let lesson38 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000038")!
        static let lesson39 = UUID(uuidString: "A1B2C3D4-1111-1111-1111-000000000039")!
    }

    func getLessons() -> [Lesson] {
        return [
            // Beginner Lessons (Free)
            Lesson(
                id: LessonID.lesson01,
                title: "Chào hỏi cơ bản",
                description: "Học cách chào hỏi trong tiếng Anh",
                level: 1,
                xpReward: 10,
                vocabularyItems: [
                    VocabularyItem(
                        english: "Hello",
                        vietnamese: "Xin chào",
                        example: "Hello! How are you?"
                    ),
                    VocabularyItem(
                        english: "Good morning",
                        vietnamese: "Chào buổi sáng",
                        example: "Good morning, teacher!"
                    ),
                    VocabularyItem(
                        english: "Good evening",
                        vietnamese: "Chào buổi tối",
                        example: "Good evening, everyone!"
                    ),
                    VocabularyItem(
                        english: "Nice to meet you",
                        vietnamese: "Rất vui được gặp bạn",
                        example: "Nice to meet you, I'm Tom."
                    ),
                    VocabularyItem(
                        english: "How are you?",
                        vietnamese: "Bạn khỏe không?",
                        example: "How are you today?"
                    )
                ],
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'Xin chào' in English?",
                        correctAnswer: "Hello",
                        options: ["Hello", "Goodbye", "Thanks", "Sorry"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'Good morning' mean?",
                        correctAnswer: "Chào buổi sáng",
                        options: ["Chào buổi sáng", "Chào buổi tối", "Tạm biệt", "Cảm ơn"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'Nice to ___ you'",
                        correctAnswer: "meet"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'How are you?'",
                        correctAnswer: "Bạn khỏe không"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is a proper greeting?",
                        correctAnswer: "Good evening",
                        options: ["Good evening", "Good night sleep", "Hello bye", "Thanks morning"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'Nice to meet you' mean?",
                        correctAnswer: "Rất vui được gặp bạn",
                        options: ["Rất vui được gặp bạn", "Tạm biệt", "Xin chào", "Cảm ơn bạn"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'Good ___ teacher!'",
                        correctAnswer: "morning"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which greeting is used in the evening?",
                        correctAnswer: "Good evening",
                        options: ["Good evening", "Good morning", "Good afternoon", "Good night"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Nice to meet you'",
                        correctAnswer: "Rất vui được gặp bạn"
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'How ___ you?'",
                        correctAnswer: "are"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "When do you say 'Good morning'?",
                        correctAnswer: "In the morning",
                        options: ["In the morning", "In the evening", "At night", "In the afternoon"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is NOT a greeting?",
                        correctAnswer: "Thank you",
                        options: ["Thank you", "Hello", "Good morning", "Hi"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson02,
                title: "Giới thiệu bản thân",
                description: "Học cách tự giới thiệu",
                level: 1,
                xpReward: 15,
                vocabularyItems: [
                    VocabularyItem(
                        english: "My name is...",
                        vietnamese: "Tên tôi là...",
                        example: "My name is Anna."
                    ),
                    VocabularyItem(
                        english: "I am from...",
                        vietnamese: "Tôi đến từ...",
                        example: "I am from Vietnam."
                    ),
                    VocabularyItem(
                        english: "I am a student",
                        vietnamese: "Tôi là học sinh",
                        example: "I am a student at ABC school."
                    ),
                    VocabularyItem(
                        english: "What is your name?",
                        vietnamese: "Bạn tên là gì?",
                        example: "What is your name?"
                    )
                ],
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'Tên tôi là...' in English?",
                        correctAnswer: "My name is...",
                        options: ["My name is...", "I am name...", "Name my is...", "I have name..."]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'I ___ from Vietnam'",
                        correctAnswer: "am"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'I am a student' mean?",
                        correctAnswer: "Tôi là học sinh",
                        options: ["Tôi là học sinh", "Tôi là giáo viên", "Tôi là bác sĩ", "Tôi đi học"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Nice to meet you'",
                        correctAnswer: "Rất vui được gặp bạn"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'What ___ your name?'",
                        correctAnswer: "is",
                        options: ["is", "are", "am", "be"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'My ___ is Tom'",
                        correctAnswer: "name"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'I am from Vietnam' mean?",
                        correctAnswer: "Tôi đến từ Việt Nam",
                        options: ["Tôi đến từ Việt Nam", "Tôi ở Việt Nam", "Tôi thích Việt Nam", "Tôi học tiếng Việt"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'What is your name?'",
                        correctAnswer: "Bạn tên là gì"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which sentence is correct?",
                        correctAnswer: "I am a student",
                        options: ["I am a student", "I is a student", "I are a student", "I be a student"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'I am ___ student'",
                        correctAnswer: "a"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you ask someone's name?",
                        correctAnswer: "What is your name?",
                        options: ["What is your name?", "How is your name?", "Where is your name?", "Who is your name?"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I am a student'",
                        correctAnswer: "Tôi là học sinh"
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson03,
                title: "Số đếm 1-20",
                description: "Học đếm số từ 1 đến 20",
                level: 1,
                xpReward: 10,
                vocabularyItems: [
                    VocabularyItem(
                        english: "One, Two, Three",
                        vietnamese: "Một, Hai, Ba",
                        example: "I have three apples."
                    ),
                    VocabularyItem(
                        english: "Five",
                        vietnamese: "Năm",
                        example: "Five plus five equals ten."
                    ),
                    VocabularyItem(
                        english: "Ten",
                        vietnamese: "Mười",
                        example: "I am ten years old."
                    ),
                    VocabularyItem(
                        english: "Fifteen",
                        vietnamese: "Mười lăm",
                        example: "The book costs fifteen dollars."
                    ),
                    VocabularyItem(
                        english: "Twenty",
                        vietnamese: "Hai mươi",
                        example: "I have twenty candies."
                    )
                ],
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What number is 'five'?",
                        correctAnswer: "5",
                        options: ["5", "15", "50", "4"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say '10' in English?",
                        correctAnswer: "ten",
                        options: ["ten", "teen", "tin", "tan"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'One, two, three, ___'",
                        correctAnswer: "four"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What comes after 'nineteen'?",
                        correctAnswer: "twenty",
                        options: ["twenty", "eighteen", "thirty", "ninety"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'fifteen'",
                        correctAnswer: "mười lăm"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What number is 'one'?",
                        correctAnswer: "1",
                        options: ["1", "11", "10", "2"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'Five, six, seven, ___'",
                        correctAnswer: "eight"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'Ba' in English?",
                        correctAnswer: "Three",
                        options: ["Three", "Two", "Four", "Five"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'Ten, eleven, ___'",
                        correctAnswer: "twelve"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What comes before 'ten'?",
                        correctAnswer: "nine",
                        options: ["nine", "eleven", "eight", "twelve"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'twenty'",
                        correctAnswer: "hai mươi"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is 10 + 10?",
                        correctAnswer: "twenty",
                        options: ["twenty", "ten", "thirty", "fifteen"]
                    )
                ],
                isPremium: false
            ),

            // Intermediate Lessons (Premium)
            Lesson(
                id: LessonID.lesson04,
                title: "Thì hiện tại đơn",
                description: "Học cách sử dụng thì hiện tại đơn",
                level: 2,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'She ___ to school every day'",
                        correctAnswer: "goes",
                        options: ["goes", "go", "going", "gone"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which sentence is correct?",
                        correctAnswer: "He plays soccer",
                        options: ["He plays soccer", "He play soccer", "He playing soccer", "He is play soccer"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'I ___ English every day' (study)",
                        correctAnswer: "study"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Negative form: 'She ___ like coffee'",
                        correctAnswer: "doesn't",
                        options: ["doesn't", "don't", "isn't", "aren't"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'They work in a hospital'",
                        correctAnswer: "Họ làm việc ở bệnh viện"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Question form: '___ you like pizza?'",
                        correctAnswer: "Do",
                        options: ["Do", "Does", "Are", "Is"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'He ___ to music every day' (listen)",
                        correctAnswer: "listens"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is the correct negative?",
                        correctAnswer: "They don't play tennis",
                        options: ["They don't play tennis", "They doesn't play tennis", "They aren't play tennis", "They isn't play tennis"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Complete: 'My sister ___ books' (love)",
                        correctAnswer: "loves"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Question form: '___ she work here?'",
                        correctAnswer: "Does",
                        options: ["Does", "Do", "Is", "Are"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I don't eat meat'",
                        correctAnswer: "Tôi không ăn thịt"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'We ___ breakfast at 7 AM'",
                        correctAnswer: "have",
                        options: ["have", "has", "having", "had"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson05,
                title: "Gia đình",
                description: "Từ vựng về các thành viên trong gia đình",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bố' in English?",
                        correctAnswer: "father",
                        options: ["father", "mother", "brother", "uncle"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'sister' mean?",
                        correctAnswer: "chị/em gái",
                        options: ["chị/em gái", "anh/em trai", "mẹ", "bà"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "My mother's mother is my ___",
                        correctAnswer: "grandmother"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you call your father's brother?",
                        correctAnswer: "uncle",
                        options: ["uncle", "aunt", "cousin", "nephew"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I have two brothers'",
                        correctAnswer: "Tôi có hai anh trai"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'mẹ' in English?",
                        correctAnswer: "mother",
                        options: ["mother", "father", "sister", "daughter"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "My father's father is my ___",
                        correctAnswer: "grandfather"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'brother' mean?",
                        correctAnswer: "anh/em trai",
                        options: ["anh/em trai", "chị/em gái", "bố", "mẹ"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you call your mother's sister?",
                        correctAnswer: "aunt",
                        options: ["aunt", "uncle", "cousin", "niece"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "My aunt's children are my ___",
                        correctAnswer: "cousins"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'My parents are kind'",
                        correctAnswer: "Bố mẹ tôi tốt bụng"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'con gái' in English?",
                        correctAnswer: "daughter",
                        options: ["daughter", "son", "sister", "mother"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson06,
                title: "Màu sắc",
                description: "Học các màu sắc cơ bản",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What color is the sky?",
                        correctAnswer: "blue",
                        options: ["blue", "green", "red", "yellow"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'màu đỏ' in English?",
                        correctAnswer: "red",
                        options: ["red", "read", "ride", "road"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Grass is ___",
                        correctAnswer: "green"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'yellow' mean?",
                        correctAnswer: "màu vàng",
                        options: ["màu vàng", "màu xanh", "màu đỏ", "màu đen"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'black and white'",
                        correctAnswer: "đen và trắng"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What color is an orange?",
                        correctAnswer: "orange",
                        options: ["orange", "purple", "brown", "pink"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The sun is ___",
                        correctAnswer: "yellow"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'màu xanh lá cây' in English?",
                        correctAnswer: "green",
                        options: ["green", "blue", "brown", "gray"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'purple' mean?",
                        correctAnswer: "màu tím",
                        options: ["màu tím", "màu hồng", "màu nâu", "màu xám"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Snow is ___",
                        correctAnswer: "white"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I like pink'",
                        correctAnswer: "Tôi thích màu hồng"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What color is chocolate?",
                        correctAnswer: "brown",
                        options: ["brown", "black", "gray", "white"]
                    )
                ],
                isPremium: false
            ),

            // Advanced Lessons (Premium)
            Lesson(
                id: LessonID.lesson07,
                title: "Thì hiện tại tiếp diễn",
                description: "Học cách diễn đạt hành động đang diễn ra",
                level: 3,
                xpReward: 25,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'I ___ studying now'",
                        correctAnswer: "am",
                        options: ["am", "is", "are", "be"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is correct?",
                        correctAnswer: "She is reading a book",
                        options: ["She is reading a book", "She reading a book", "She are reading a book", "She read a book"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "They ___ playing soccer (use present continuous)",
                        correctAnswer: "are"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What's the negative form: 'He ___ working'",
                        correctAnswer: "isn't",
                        options: ["isn't", "doesn't", "don't", "aren't"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'We are having dinner'",
                        correctAnswer: "Chúng tôi đang ăn tối"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'You ___ watching TV'",
                        correctAnswer: "are",
                        options: ["are", "is", "am", "be"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "She is ___ to music (listen)",
                        correctAnswer: "listening"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is the correct question form?",
                        correctAnswer: "Are you sleeping?",
                        options: ["Are you sleeping?", "You are sleeping?", "Do you sleeping?", "Is you sleeping?"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I am ___ my homework (do)",
                        correctAnswer: "doing"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What's the negative: 'They ___ coming'",
                        correctAnswer: "aren't",
                        options: ["aren't", "isn't", "don't", "doesn't"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'He is running'",
                        correctAnswer: "Anh ấy đang chạy"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'The baby ___ crying'",
                        correctAnswer: "is",
                        options: ["is", "are", "am", "be"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson08,
                title: "Thức ăn và đồ uống",
                description: "Từ vựng về đồ ăn, thức uống",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'nước' in English?",
                        correctAnswer: "water",
                        options: ["water", "juice", "milk", "coffee"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'bread' mean?",
                        correctAnswer: "bánh mì",
                        options: ["bánh mì", "cơm", "phở", "bún"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I like to drink ___ in the morning (coffee/tea)",
                        correctAnswer: "coffee"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is a fruit?",
                        correctAnswer: "apple",
                        options: ["apple", "chicken", "rice", "potato"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I want some rice'",
                        correctAnswer: "Tôi muốn một ít cơm"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'sữa' in English?",
                        correctAnswer: "milk",
                        options: ["milk", "water", "juice", "tea"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I eat ___ for breakfast (cereal/eggs/toast)",
                        correctAnswer: "eggs"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'chicken' mean?",
                        correctAnswer: "thịt gà",
                        options: ["thịt gà", "thịt heo", "thịt bò", "cá"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is a drink?",
                        correctAnswer: "tea",
                        options: ["tea", "sandwich", "pizza", "salad"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I'm hungry. I want some ___",
                        correctAnswer: "food"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She drinks orange juice'",
                        correctAnswer: "Cô ấy uống nước cam"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'cá' in English?",
                        correctAnswer: "fish",
                        options: ["fish", "meat", "chicken", "pork"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson09,
                title: "Hỏi đường",
                description: "Học cách hỏi và chỉ đường",
                level: 3,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you ask for directions politely?",
                        correctAnswer: "Excuse me, where is...?",
                        options: ["Excuse me, where is...?", "Hey, where...?", "Tell me where...", "I want know where..."]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'turn left' mean?",
                        correctAnswer: "rẽ trái",
                        options: ["rẽ trái", "rẽ phải", "đi thẳng", "quay lại"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Go ___ for two blocks (straight/left/right)",
                        correctAnswer: "straight"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'It's ___ the left'",
                        correctAnswer: "on",
                        options: ["on", "in", "at", "to"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Turn right at the traffic light'",
                        correctAnswer: "Rẽ phải ở đèn giao thông"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'turn right' mean?",
                        correctAnswer: "rẽ phải",
                        options: ["rẽ phải", "rẽ trái", "đi thẳng", "quay lại"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Go straight ___ two blocks",
                        correctAnswer: "for"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'đi thẳng' in English?",
                        correctAnswer: "go straight",
                        options: ["go straight", "turn left", "turn right", "go back"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'It's ___ the corner'",
                        correctAnswer: "on",
                        options: ["on", "in", "at", "to"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The bank is ___ to the post office",
                        correctAnswer: "next"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Where is the library?'",
                        correctAnswer: "Thư viện ở đâu"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'go back' mean?",
                        correctAnswer: "quay lại",
                        options: ["quay lại", "đi thẳng", "rẽ trái", "rẽ phải"]
                    )
                ],
                isPremium: false
            ),

            // Level 1 - More Beginner Lessons (FREE)
            Lesson(
                id: LessonID.lesson10,
                title: "Động vật cơ bản",
                description: "Học tên các con vật phổ biến",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What animal says 'meow'?",
                        correctAnswer: "cat",
                        options: ["cat", "dog", "cow", "duck"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'con chó' in English?",
                        correctAnswer: "dog",
                        options: ["dog", "god", "dig", "dug"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ can fly (bird/fish/cat)",
                        correctAnswer: "bird"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'elephant' mean?",
                        correctAnswer: "con voi",
                        options: ["con voi", "con ngựa", "con bò", "con mèo"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I have a pet rabbit'",
                        correctAnswer: "Tôi có một con thỏ"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What animal says 'woof woof'?",
                        correctAnswer: "dog",
                        options: ["dog", "cat", "bird", "frog"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ can swim (fish/bird/cat)",
                        correctAnswer: "fish"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'con mèo' in English?",
                        correctAnswer: "cat",
                        options: ["cat", "rat", "bat", "hat"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'horse' mean?",
                        correctAnswer: "con ngựa",
                        options: ["con ngựa", "con bò", "con heo", "con dê"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ gives us milk",
                        correctAnswer: "cow"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The bird is singing'",
                        correctAnswer: "Con chim đang hót"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which animal can jump very high?",
                        correctAnswer: "frog",
                        options: ["frog", "fish", "snake", "turtle"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson11,
                title: "Bộ phận cơ thể",
                description: "Học tên các bộ phận trên cơ thể",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to see?",
                        correctAnswer: "eyes",
                        options: ["eyes", "ears", "nose", "mouth"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'tay' in English?",
                        correctAnswer: "hand",
                        options: ["hand", "head", "hair", "heart"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "You wear shoes on your ___",
                        correctAnswer: "feet"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'nose' mean?",
                        correctAnswer: "mũi",
                        options: ["mũi", "miệng", "tai", "mắt"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'My head hurts'",
                        correctAnswer: "Đầu tôi đau"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to hear?",
                        correctAnswer: "ears",
                        options: ["ears", "eyes", "nose", "mouth"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I brush my ___ every day",
                        correctAnswer: "teeth"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'chân' in English?",
                        correctAnswer: "leg",
                        options: ["leg", "arm", "foot", "hand"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'mouth' mean?",
                        correctAnswer: "miệng",
                        options: ["miệng", "mũi", "tai", "mắt"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "You wave with your ___",
                        correctAnswer: "hand"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She has long hair'",
                        correctAnswer: "Cô ấy có mái tóc dài"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to smell flowers?",
                        correctAnswer: "nose",
                        options: ["nose", "eyes", "ears", "hands"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson12,
                title: "Trường học",
                description: "Từ vựng về trường học",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you write with?",
                        correctAnswer: "pen",
                        options: ["pen", "book", "desk", "chair"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'giáo viên' in English?",
                        correctAnswer: "teacher",
                        options: ["teacher", "student", "school", "class"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I read a ___",
                        correctAnswer: "book"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'classroom' mean?",
                        correctAnswer: "lớp học",
                        options: ["lớp học", "sân trường", "thư viện", "phòng ăn"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I go to school'",
                        correctAnswer: "Tôi đi học"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'học sinh' in English?",
                        correctAnswer: "student",
                        options: ["student", "teacher", "principal", "class"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I sit on a ___",
                        correctAnswer: "chair"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'desk' mean?",
                        correctAnswer: "bàn học",
                        options: ["bàn học", "ghế", "bảng", "sách"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to draw?",
                        correctAnswer: "pencil",
                        options: ["pencil", "book", "desk", "eraser"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The teacher writes on the ___",
                        correctAnswer: "board"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I study English'",
                        correctAnswer: "Tôi học tiếng Anh"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bảng đen' in English?",
                        correctAnswer: "blackboard",
                        options: ["blackboard", "whiteboard", "notebook", "textbook"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson13,
                title: "Thời tiết",
                description: "Học cách nói về thời tiết",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What's the weather when water falls from the sky?",
                        correctAnswer: "rainy",
                        options: ["rainy", "sunny", "windy", "cloudy"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'trời nóng' in English?",
                        correctAnswer: "hot",
                        options: ["hot", "cold", "warm", "cool"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "It's ___ today! (sunny/cloudy)",
                        correctAnswer: "sunny"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'snow' mean?",
                        correctAnswer: "tuyết",
                        options: ["tuyết", "mưa", "gió", "mây"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'It's cold today'",
                        correctAnswer: "Hôm nay trời lạnh"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What's the weather when you can't see the sun?",
                        correctAnswer: "cloudy",
                        options: ["cloudy", "sunny", "snowy", "clear"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "It's ___ outside. Bring an umbrella! (raining/sunny)",
                        correctAnswer: "raining"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'trời mát' in English?",
                        correctAnswer: "cool",
                        options: ["cool", "cold", "hot", "warm"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'windy' mean?",
                        correctAnswer: "có gió",
                        options: ["có gió", "mưa", "nắng", "lạnh"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The weather is ___ today (nice/bad)",
                        correctAnswer: "nice"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'It's very hot'",
                        correctAnswer: "Trời rất nóng"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "When do you see rain?",
                        correctAnswer: "rainy day",
                        options: ["rainy day", "sunny day", "windy day", "snowy day"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson14,
                title: "Ngày trong tuần",
                description: "Học các ngày trong tuần",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What day comes after Monday?",
                        correctAnswer: "Tuesday",
                        options: ["Tuesday", "Wednesday", "Sunday", "Friday"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'Thứ bảy' in English?",
                        correctAnswer: "Saturday",
                        options: ["Saturday", "Sunday", "Friday", "Thursday"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The weekend is Saturday and ___",
                        correctAnswer: "Sunday"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'Wednesday' mean?",
                        correctAnswer: "Thứ tư",
                        options: ["Thứ tư", "Thứ ba", "Thứ năm", "Thứ sáu"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I go to school on Friday'",
                        correctAnswer: "Tôi đi học vào thứ sáu"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the first day of the week?",
                        correctAnswer: "Monday",
                        options: ["Monday", "Sunday", "Tuesday", "Saturday"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Today is Monday. Tomorrow is ___",
                        correctAnswer: "Tuesday"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'Chủ nhật' in English?",
                        correctAnswer: "Sunday",
                        options: ["Sunday", "Saturday", "Monday", "Friday"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'Thursday' mean?",
                        correctAnswer: "Thứ năm",
                        options: ["Thứ năm", "Thứ tư", "Thứ sáu", "Thứ ba"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Wednesday comes after ___",
                        correctAnswer: "Tuesday"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I rest on Sunday'",
                        correctAnswer: "Tôi nghỉ vào chủ nhật"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How many days are in a week?",
                        correctAnswer: "7",
                        options: ["7", "5", "6", "8"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson15,
                title: "Tháng trong năm",
                description: "Học 12 tháng trong năm",
                level: 1,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the first month of the year?",
                        correctAnswer: "January",
                        options: ["January", "February", "March", "December"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which month has Christmas?",
                        correctAnswer: "December",
                        options: ["December", "November", "October", "September"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Summer vacation is in ___",
                        correctAnswer: "July"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'April' mean?",
                        correctAnswer: "Tháng 4",
                        options: ["Tháng 4", "Tháng 3", "Tháng 5", "Tháng 6"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'My birthday is in May'",
                        correctAnswer: "Sinh nhật tôi vào tháng 5"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the last month of the year?",
                        correctAnswer: "December",
                        options: ["December", "November", "January", "October"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "January, February, ___",
                        correctAnswer: "March"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'Tháng 6' in English?",
                        correctAnswer: "June",
                        options: ["June", "July", "May", "January"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'September' mean?",
                        correctAnswer: "Tháng 9",
                        options: ["Tháng 9", "Tháng 7", "Tháng 8", "Tháng 10"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "School starts in ___",
                        correctAnswer: "September"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I love February'",
                        correctAnswer: "Tôi thích tháng 2"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How many months are in a year?",
                        correctAnswer: "12",
                        options: ["12", "10", "11", "13"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson16,
                title: "Hình dạng",
                description: "Học các hình dạng cơ bản",
                level: 1,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What shape is a ball?",
                        correctAnswer: "circle",
                        options: ["circle", "square", "triangle", "rectangle"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'hình vuông' in English?",
                        correctAnswer: "square",
                        options: ["square", "circle", "star", "heart"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ has three sides",
                        correctAnswer: "triangle"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'star' mean?",
                        correctAnswer: "ngôi sao",
                        options: ["ngôi sao", "hình vuông", "hình tròn", "hình tim"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I drew a heart'",
                        correctAnswer: "Tôi vẽ một hình tim"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What shape has four equal sides?",
                        correctAnswer: "square",
                        options: ["square", "rectangle", "triangle", "circle"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ has no corners",
                        correctAnswer: "circle"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'hình chữ nhật' in English?",
                        correctAnswer: "rectangle",
                        options: ["rectangle", "square", "triangle", "oval"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'oval' mean?",
                        correctAnswer: "hình bầu dục",
                        options: ["hình bầu dục", "hình tròn", "hình vuông", "hình tam giác"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A stop sign has ___ sides",
                        correctAnswer: "eight"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The pizza is round'",
                        correctAnswer: "Chiếc pizza hình tròn"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How many sides does a triangle have?",
                        correctAnswer: "3",
                        options: ["3", "4", "5", "6"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson17,
                title: "Bảng chữ cái",
                description: "Học bảng chữ cái tiếng Anh",
                level: 1,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What letter comes after B?",
                        correctAnswer: "C",
                        options: ["C", "D", "A", "E"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the last letter of the alphabet?",
                        correctAnswer: "Z",
                        options: ["Z", "Y", "X", "W"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A, B, C, ___, E",
                        correctAnswer: "D"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How many letters are in the English alphabet?",
                        correctAnswer: "26",
                        options: ["26", "24", "28", "30"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "What are the first three letters?",
                        correctAnswer: "A B C"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What letter comes before G?",
                        correctAnswer: "F",
                        options: ["F", "H", "E", "I"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "W, X, Y, ___",
                        correctAnswer: "Z"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the first letter of the alphabet?",
                        correctAnswer: "A",
                        options: ["A", "B", "C", "D"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which letters are vowels?",
                        correctAnswer: "A E I O U",
                        options: ["A E I O U", "B C D F G", "L M N P Q", "R S T V W"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "M, N, ___, P",
                        correctAnswer: "O"
                    ),
                    Question(
                        type: .translation,
                        prompt: "How do you spell 'CAT'?",
                        correctAnswer: "C A T"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What letter comes after S?",
                        correctAnswer: "T",
                        options: ["T", "U", "R", "V"]
                    )
                ],
                isPremium: false
            ),

            // Level 2 - Intermediate Lessons (Mix FREE/PREMIUM)
            Lesson(
                id: LessonID.lesson18,
                title: "Động vật vườn thú",
                description: "Học tên động vật ở sở thú",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What animal has a long trunk?",
                        correctAnswer: "elephant",
                        options: ["elephant", "giraffe", "monkey", "lion"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'con sư tử' in English?",
                        correctAnswer: "lion",
                        options: ["lion", "tiger", "bear", "wolf"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ has a very long neck",
                        correctAnswer: "giraffe"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'monkey' mean?",
                        correctAnswer: "con khỉ",
                        options: ["con khỉ", "con voi", "con hổ", "con gấu"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The zebra has stripes'",
                        correctAnswer: "Con ngựa vằn có sọc"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What animal is the king of the jungle?",
                        correctAnswer: "lion",
                        options: ["lion", "tiger", "bear", "elephant"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ swings from trees",
                        correctAnswer: "monkey"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'con hổ' in English?",
                        correctAnswer: "tiger",
                        options: ["tiger", "lion", "leopard", "cheetah"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'bear' mean?",
                        correctAnswer: "con gấu",
                        options: ["con gấu", "con hổ", "con khỉ", "con voi"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ eats bamboo (panda/koala/bear)",
                        correctAnswer: "panda"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I see a big elephant'",
                        correctAnswer: "Tôi thấy một con voi lớn"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which animal has black and white stripes?",
                        correctAnswer: "zebra",
                        options: ["zebra", "tiger", "giraffe", "panda"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson19,
                title: "Quần áo",
                description: "Từ vựng về quần áo",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you wear on your feet?",
                        correctAnswer: "shoes",
                        options: ["shoes", "hat", "gloves", "shirt"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'áo sơ mi' in English?",
                        correctAnswer: "shirt",
                        options: ["shirt", "skirt", "shorts", "shoes"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I wear a ___ on my head",
                        correctAnswer: "hat"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'pants' mean?",
                        correctAnswer: "quần dài",
                        options: ["quần dài", "áo", "váy", "giày"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She wears a dress'",
                        correctAnswer: "Cô ấy mặc váy"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you wear when it's cold?",
                        correctAnswer: "jacket",
                        options: ["jacket", "shorts", "t-shirt", "sandals"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I wear ___ on my hands when it's cold",
                        correctAnswer: "gloves"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'quần short' in English?",
                        correctAnswer: "shorts",
                        options: ["shorts", "pants", "skirt", "jeans"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'socks' mean?",
                        correctAnswer: "tất",
                        options: ["tất", "giày", "găng tay", "mũ"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Girls often wear a ___",
                        correctAnswer: "skirt"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'He wears blue jeans'",
                        correctAnswer: "Anh ấy mặc quần jean xanh"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you wear to sleep?",
                        correctAnswer: "pajamas",
                        options: ["pajamas", "suit", "dress", "uniform"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson20,
                title: "Thể thao",
                description: "Từ vựng về các môn thể thao",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What sport uses a ball and a hoop?",
                        correctAnswer: "basketball",
                        options: ["basketball", "swimming", "running", "tennis"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bóng đá' in English?",
                        correctAnswer: "soccer",
                        options: ["soccer", "volleyball", "badminton", "tennis"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I like to play ___",
                        correctAnswer: "tennis"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'swimming' mean?",
                        correctAnswer: "bơi lội",
                        options: ["bơi lội", "chạy", "nhảy", "đạp xe"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'He plays basketball'",
                        correctAnswer: "Anh ấy chơi bóng rổ"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What sport is played on ice?",
                        correctAnswer: "hockey",
                        options: ["hockey", "baseball", "volleyball", "golf"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I play ___ with a racket (tennis/badminton)",
                        correctAnswer: "badminton"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bóng chuyền' in English?",
                        correctAnswer: "volleyball",
                        options: ["volleyball", "basketball", "football", "handball"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'running' mean?",
                        correctAnswer: "chạy",
                        options: ["chạy", "bơi", "nhảy", "leo"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "You need a bat to play ___",
                        correctAnswer: "baseball"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I can swim fast'",
                        correctAnswer: "Tôi có thể bơi nhanh"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which sport uses a shuttlecock?",
                        correctAnswer: "badminton",
                        options: ["badminton", "tennis", "ping pong", "volleyball"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson21,
                title: "Trái cây",
                description: "Học tên các loại trái cây",
                level: 2,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What fruit is yellow and curved?",
                        correctAnswer: "banana",
                        options: ["banana", "apple", "orange", "grape"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'quả cam' in English?",
                        correctAnswer: "orange",
                        options: ["orange", "lemon", "lime", "grapefruit"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "An ___ a day keeps the doctor away",
                        correctAnswer: "apple"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'watermelon' mean?",
                        correctAnswer: "dưa hấu",
                        options: ["dưa hấu", "dưa chuột", "cam", "chuối"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I like strawberries'",
                        correctAnswer: "Tôi thích dâu tây"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which fruit is purple?",
                        correctAnswer: "grape",
                        options: ["grape", "apple", "banana", "orange"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Monkeys love to eat ___",
                        correctAnswer: "bananas"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'quả dâu' in English?",
                        correctAnswer: "strawberry",
                        options: ["strawberry", "raspberry", "blueberry", "cherry"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'pineapple' mean?",
                        correctAnswer: "dứa",
                        options: ["dứa", "táo", "cam", "nho"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ is red and round (apple/banana)",
                        correctAnswer: "apple"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She eats a pear'",
                        correctAnswer: "Cô ấy ăn quả lê"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which fruit is green inside?",
                        correctAnswer: "kiwi",
                        options: ["kiwi", "strawberry", "cherry", "peach"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson22,
                title: "Rau củ",
                description: "Học tên các loại rau củ",
                level: 2,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What vegetable is orange and long?",
                        correctAnswer: "carrot",
                        options: ["carrot", "potato", "onion", "cabbage"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'cà chua' in English?",
                        correctAnswer: "tomato",
                        options: ["tomato", "potato", "onion", "pepper"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Popeye eats ___ to be strong",
                        correctAnswer: "spinach"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'broccoli' mean?",
                        correctAnswer: "bông cải xanh",
                        options: ["bông cải xanh", "cà rốt", "khoai tây", "hành tây"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I eat vegetables every day'",
                        correctAnswer: "Tôi ăn rau mỗi ngày"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What vegetable makes you cry when you cut it?",
                        correctAnswer: "onion",
                        options: ["onion", "carrot", "potato", "cabbage"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "French fries are made from ___",
                        correctAnswer: "potatoes"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bắp cải' in English?",
                        correctAnswer: "cabbage",
                        options: ["cabbage", "lettuce", "spinach", "kale"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'cucumber' mean?",
                        correctAnswer: "dưa chuột",
                        options: ["dưa chuột", "cà chua", "cà rốt", "khoai tây"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ is green and used in salad",
                        correctAnswer: "lettuce"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Carrots are healthy'",
                        correctAnswer: "Cà rốt tốt cho sức khỏe"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which vegetable is red?",
                        correctAnswer: "tomato",
                        options: ["tomato", "broccoli", "celery", "cauliflower"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson23,
                title: "Đồ chơi",
                description: "Từ vựng về đồ chơi",
                level: 2,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What toy can you throw and catch?",
                        correctAnswer: "ball",
                        options: ["ball", "doll", "puzzle", "blocks"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'búp bê' in English?",
                        correctAnswer: "doll",
                        options: ["doll", "ball", "toy", "game"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I like to play with my ___",
                        correctAnswer: "toys"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'puzzle' mean?",
                        correctAnswer: "tranh ghép",
                        options: ["tranh ghép", "búp bê", "bóng", "xe"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I have many toys'",
                        correctAnswer: "Tôi có nhiều đồ chơi"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What toy has wheels and you can ride it?",
                        correctAnswer: "bicycle",
                        options: ["bicycle", "doll", "puzzle", "ball"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Children build towers with ___",
                        correctAnswer: "blocks"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'xe ô tô đồ chơi' in English?",
                        correctAnswer: "toy car",
                        options: ["toy car", "doll car", "play car", "mini car"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'teddy bear' mean?",
                        correctAnswer: "gấu bông",
                        options: ["gấu bông", "búp bê", "xe đồ chơi", "bóng"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I play video ___ on my computer",
                        correctAnswer: "games"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She loves her doll'",
                        correctAnswer: "Cô ấy yêu búp bê của mình"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What toy flies in the sky?",
                        correctAnswer: "kite",
                        options: ["kite", "ball", "car", "robot"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson24,
                title: "Phòng trong nhà",
                description: "Các phòng trong ngôi nhà",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Where do you sleep?",
                        correctAnswer: "bedroom",
                        options: ["bedroom", "kitchen", "bathroom", "living room"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'nhà bếp' in English?",
                        correctAnswer: "kitchen",
                        options: ["kitchen", "chicken", "garden", "garage"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I take a shower in the ___",
                        correctAnswer: "bathroom"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'living room' mean?",
                        correctAnswer: "phòng khách",
                        options: ["phòng khách", "phòng ngủ", "nhà bếp", "phòng tắm"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The dining room is big'",
                        correctAnswer: "Phòng ăn rộng"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Where do you eat dinner with your family?",
                        correctAnswer: "dining room",
                        options: ["dining room", "bedroom", "garage", "bathroom"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I watch TV in the ___ room",
                        correctAnswer: "living"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'phòng ngủ' in English?",
                        correctAnswer: "bedroom",
                        options: ["bedroom", "bathroom", "living room", "kitchen"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'garage' mean?",
                        correctAnswer: "nhà để xe",
                        options: ["nhà để xe", "phòng ngủ", "nhà bếp", "phòng tắm"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I brush my teeth in the ___",
                        correctAnswer: "bathroom"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'My house has five rooms'",
                        correctAnswer: "Nhà tôi có năm phòng"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Where do you cook food?",
                        correctAnswer: "kitchen",
                        options: ["kitchen", "bedroom", "garden", "closet"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson25,
                title: "Đồ dùng học tập",
                description: "Đồ dùng cần thiết cho học tập",
                level: 2,
                xpReward: 10,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to erase pencil marks?",
                        correctAnswer: "eraser",
                        options: ["eraser", "ruler", "pen", "glue"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'thước kẻ' in English?",
                        correctAnswer: "ruler",
                        options: ["ruler", "eraser", "pencil", "scissors"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I carry my books in a ___",
                        correctAnswer: "backpack"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'scissors' mean?",
                        correctAnswer: "cái kéo",
                        options: ["cái kéo", "bút chì", "thước", "tẩy"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I need a pencil'",
                        correctAnswer: "Tôi cần một cây bút chì"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to cut paper?",
                        correctAnswer: "scissors",
                        options: ["scissors", "glue", "tape", "stapler"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I use ___ to stick paper together",
                        correctAnswer: "glue"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bút màu' in English?",
                        correctAnswer: "crayons",
                        options: ["crayons", "markers", "pencils", "pens"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'notebook' mean?",
                        correctAnswer: "vở ghi chép",
                        options: ["vở ghi chép", "sách giáo khoa", "bút", "thước"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I sharpen my ___ when it's dull",
                        correctAnswer: "pencil"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She has a red pen'",
                        correctAnswer: "Cô ấy có một cây bút đỏ"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you use to draw straight lines?",
                        correctAnswer: "ruler",
                        options: ["ruler", "eraser", "pen", "glue"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson26,
                title: "Cảm xúc",
                description: "Học cách diễn đạt cảm xúc",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you feel when you get a gift?",
                        correctAnswer: "happy",
                        options: ["happy", "sad", "angry", "tired"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'buồn' in English?",
                        correctAnswer: "sad",
                        options: ["sad", "mad", "bad", "glad"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I am ___ when I'm sleepy",
                        correctAnswer: "tired"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'excited' mean?",
                        correctAnswer: "phấn khích",
                        options: ["phấn khích", "buồn", "tức giận", "mệt mỏi"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I feel scared'",
                        correctAnswer: "Tôi cảm thấy sợ hãi"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you feel when someone hurts you?",
                        correctAnswer: "angry",
                        options: ["angry", "happy", "excited", "proud"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I am ___ when I lose a game",
                        correctAnswer: "sad"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'tức giận' in English?",
                        correctAnswer: "angry",
                        options: ["angry", "hungry", "tired", "scared"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'nervous' mean?",
                        correctAnswer: "lo lắng",
                        options: ["lo lắng", "vui vẻ", "buồn", "giận dữ"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I feel ___ when I win",
                        correctAnswer: "proud"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'He is very happy'",
                        correctAnswer: "Anh ấy rất vui"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you feel on your birthday?",
                        correctAnswer: "excited",
                        options: ["excited", "bored", "angry", "scared"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson27,
                title: "Nghề nghiệp",
                description: "Các nghề nghiệp phổ biến",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Who teaches students?",
                        correctAnswer: "teacher",
                        options: ["teacher", "doctor", "chef", "pilot"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bác sĩ' in English?",
                        correctAnswer: "doctor",
                        options: ["doctor", "nurse", "teacher", "dentist"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ cooks food in a restaurant",
                        correctAnswer: "chef"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'firefighter' mean?",
                        correctAnswer: "lính cứu hỏa",
                        options: ["lính cứu hỏa", "cảnh sát", "phi công", "nông dân"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'My mom is a nurse'",
                        correctAnswer: "Mẹ tôi là y tá"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Who flies an airplane?",
                        correctAnswer: "pilot",
                        options: ["pilot", "driver", "sailor", "conductor"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ helps sick people",
                        correctAnswer: "doctor"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'cảnh sát' in English?",
                        correctAnswer: "police officer",
                        options: ["police officer", "firefighter", "soldier", "guard"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'artist' mean?",
                        correctAnswer: "họa sĩ",
                        options: ["họa sĩ", "ca sĩ", "diễn viên", "vũ công"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A ___ grows food on a farm",
                        correctAnswer: "farmer"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I want to be a scientist'",
                        correctAnswer: "Tôi muốn trở thành nhà khoa học"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Who fixes cars?",
                        correctAnswer: "mechanic",
                        options: ["mechanic", "carpenter", "plumber", "electrician"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson28,
                title: "Giờ trong ngày",
                description: "Học cách đọc giờ",
                level: 2,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What time do you eat breakfast?",
                        correctAnswer: "morning",
                        options: ["morning", "afternoon", "evening", "night"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'buổi trưa' in English?",
                        correctAnswer: "noon",
                        options: ["noon", "moon", "soon", "spoon"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "It's ___ o'clock (time number)",
                        correctAnswer: "twelve"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'midnight' mean?",
                        correctAnswer: "nửa đêm",
                        options: ["nửa đêm", "trưa", "sáng", "chiều"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'It's three thirty'",
                        correctAnswer: "Ba giờ ba mươi"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What time of day do you eat lunch?",
                        correctAnswer: "afternoon",
                        options: ["afternoon", "morning", "evening", "night"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I go to bed at ___",
                        correctAnswer: "night"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'buổi chiều' in English?",
                        correctAnswer: "afternoon",
                        options: ["afternoon", "morning", "evening", "noon"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'dawn' mean?",
                        correctAnswer: "bình minh",
                        options: ["bình minh", "hoàng hôn", "trưa", "đêm"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The sun sets in the ___",
                        correctAnswer: "evening"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'What time is it?'",
                        correctAnswer: "Mấy giờ rồi"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "When do you see stars?",
                        correctAnswer: "at night",
                        options: ["at night", "in the morning", "at noon", "in the afternoon"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson29,
                title: "Hoạt động hàng ngày",
                description: "Các hoạt động thường ngày",
                level: 2,
                xpReward: 15,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you do in the morning?",
                        correctAnswer: "wake up",
                        options: ["wake up", "go to bed", "have dinner", "watch TV"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'đánh răng' in English?",
                        correctAnswer: "brush teeth",
                        options: ["brush teeth", "wash face", "comb hair", "take shower"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I ___ my homework after school",
                        correctAnswer: "do"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'take a shower' mean?",
                        correctAnswer: "tắm",
                        options: ["tắm", "ăn", "ngủ", "học"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I go to bed at 9 PM'",
                        correctAnswer: "Tôi đi ngủ lúc 9 giờ tối"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you do before breakfast?",
                        correctAnswer: "wash face",
                        options: ["wash face", "have dinner", "do homework", "watch TV"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I ___ my hair every morning",
                        correctAnswer: "comb"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'ăn sáng' in English?",
                        correctAnswer: "have breakfast",
                        options: ["have breakfast", "have lunch", "have dinner", "have snack"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'get dressed' mean?",
                        correctAnswer: "mặc quần áo",
                        options: ["mặc quần áo", "tắm", "ngủ", "ăn"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I ___ TV after dinner",
                        correctAnswer: "watch"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She reads books every night'",
                        correctAnswer: "Cô ấy đọc sách mỗi tối"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you do at school?",
                        correctAnswer: "study",
                        options: ["study", "sleep", "cook", "shop"]
                    )
                ],
                isPremium: false
            ),

            // Level 3 - Advanced Lessons (PREMIUM)
            Lesson(
                id: LessonID.lesson30,
                title: "Thì quá khứ đơn",
                description: "Học cách kể về quá khứ",
                level: 3,
                xpReward: 25,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'I ___ to the park yesterday'",
                        correctAnswer: "went",
                        options: ["went", "go", "going", "goes"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the past tense of 'eat'?",
                        correctAnswer: "ate",
                        options: ["ate", "eated", "eating", "eaten"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "She ___ a movie last night (watch)",
                        correctAnswer: "watched"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which sentence is correct?",
                        correctAnswer: "He played soccer",
                        options: ["He played soccer", "He play soccer", "He playing soccer", "He plays soccer"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'We visited our grandparents'",
                        correctAnswer: "Chúng tôi đã thăm ông bà"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the past tense of 'go'?",
                        correctAnswer: "went",
                        options: ["went", "goed", "going", "gone"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I ___ a letter yesterday (write)",
                        correctAnswer: "wrote"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the past tense of 'see'?",
                        correctAnswer: "saw",
                        options: ["saw", "seed", "seen", "seeing"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is the correct negative?",
                        correctAnswer: "She didn't come",
                        options: ["She didn't come", "She doesn't came", "She not came", "She don't come"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "They ___ soccer last week (play)",
                        correctAnswer: "played"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I studied English yesterday'",
                        correctAnswer: "Tôi đã học tiếng Anh hôm qua"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the past tense of 'buy'?",
                        correctAnswer: "bought",
                        options: ["bought", "buyed", "buying", "buyed"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson31,
                title: "So sánh hơn",
                description: "Học cách so sánh",
                level: 3,
                xpReward: 25,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'My brother is ___ than me'",
                        correctAnswer: "taller",
                        options: ["taller", "more tall", "tallest", "tall"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the comparative of 'good'?",
                        correctAnswer: "better",
                        options: ["better", "gooder", "more good", "best"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "A car is ___ than a bicycle (fast)",
                        correctAnswer: "faster"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'This book is ___ interesting than that one'",
                        correctAnswer: "more",
                        options: ["more", "most", "much", "many"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'She is younger than her sister'",
                        correctAnswer: "Cô ấy trẻ hơn chị gái"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the comparative of 'bad'?",
                        correctAnswer: "worse",
                        options: ["worse", "badder", "more bad", "worst"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "An elephant is ___ than a mouse (big)",
                        correctAnswer: "bigger"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'This test is ___ difficult than the last one'",
                        correctAnswer: "more",
                        options: ["more", "most", "much", "many"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the comparative of 'hot'?",
                        correctAnswer: "hotter",
                        options: ["hotter", "hoter", "more hot", "hottest"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Gold is ___ than silver (expensive)",
                        correctAnswer: "more expensive"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'He runs faster than me'",
                        correctAnswer: "Anh ấy chạy nhanh hơn tôi"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is correct?",
                        correctAnswer: "She is smarter than him",
                        options: ["She is smarter than him", "She is more smart than him", "She smarter than him", "She is smartest than him"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson32,
                title: "Động từ khuyết thiếu",
                description: "Can, should, must",
                level: 3,
                xpReward: 25,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'I ___ swim very well'",
                        correctAnswer: "can",
                        options: ["can", "should", "must", "may"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What means you have to do something?",
                        correctAnswer: "must",
                        options: ["must", "can", "may", "could"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "You ___ brush your teeth every day",
                        correctAnswer: "should"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is correct?",
                        correctAnswer: "She can play piano",
                        options: ["She can play piano", "She cans play piano", "She can plays piano", "She can playing piano"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'You must do your homework'",
                        correctAnswer: "Bạn phải làm bài tập"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: '___ I use your phone?'",
                        correctAnswer: "May",
                        options: ["May", "Must", "Should", "Would"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "You ___ eat too much candy (should/shouldn't)",
                        correctAnswer: "shouldn't"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'You must stop' mean?",
                        correctAnswer: "Bạn phải dừng lại",
                        options: ["Bạn phải dừng lại", "Bạn nên dừng lại", "Bạn có thể dừng lại", "Bạn muốn dừng lại"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'She ___ speak three languages'",
                        correctAnswer: "can",
                        options: ["can", "cans", "could", "may"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "We ___ arrive on time (must/can/may)",
                        correctAnswer: "must"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'You should study hard'",
                        correctAnswer: "Bạn nên học chăm chỉ"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is the negative of 'can'?",
                        correctAnswer: "cannot",
                        options: ["cannot", "can not", "must not", "should not"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson33,
                title: "Giới từ",
                description: "In, on, at, under, between...",
                level: 3,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "The book is ___ the table",
                        correctAnswer: "on",
                        options: ["on", "in", "at", "to"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'The cat is ___ the box'",
                        correctAnswer: "in",
                        options: ["in", "on", "at", "by"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The ball is ___ the table",
                        correctAnswer: "under"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "I live ___ Vietnam",
                        correctAnswer: "in",
                        options: ["in", "on", "at", "to"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The dog is between the trees'",
                        correctAnswer: "Con chó ở giữa các cây"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'The picture is ___ the wall'",
                        correctAnswer: "on",
                        options: ["on", "in", "at", "under"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I sit ___ my friend (next to/between)",
                        correctAnswer: "next to"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Where is the mouse? It's ___ the chair",
                        correctAnswer: "under",
                        options: ["under", "on", "in", "at"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'She lives ___ London'",
                        correctAnswer: "in",
                        options: ["in", "on", "at", "to"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "The keys are ___ the table",
                        correctAnswer: "on"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The cat is behind the door'",
                        correctAnswer: "Con mèo ở đằng sau cửa"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'I arrived ___ 5 PM'",
                        correctAnswer: "at",
                        options: ["at", "in", "on", "to"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson34,
                title: "Tương lai đơn",
                description: "Học cách nói về tương lai",
                level: 3,
                xpReward: 25,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'I ___ go to school tomorrow'",
                        correctAnswer: "will",
                        options: ["will", "am", "was", "going"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What's the negative: 'She ___ come'",
                        correctAnswer: "won't",
                        options: ["won't", "don't", "doesn't", "isn't"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "We ___ have a test next week",
                        correctAnswer: "will"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is correct?",
                        correctAnswer: "They will play",
                        options: ["They will play", "They will plays", "They will playing", "They will to play"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'It will rain tomorrow'",
                        correctAnswer: "Ngày mai trời sẽ mưa"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'He ___ be here soon'",
                        correctAnswer: "will",
                        options: ["will", "is", "was", "going"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I ___ call you later",
                        correctAnswer: "will"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What is the question form?",
                        correctAnswer: "Will you help me?",
                        options: ["Will you help me?", "You will help me?", "Do you will help me?", "Are you will help me?"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Complete: 'They ___ not come to the party'",
                        correctAnswer: "will",
                        options: ["will", "are", "do", "can"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "She ___ visit us next month",
                        correctAnswer: "will"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I will study tomorrow'",
                        correctAnswer: "Tôi sẽ học vào ngày mai"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is correct?",
                        correctAnswer: "We will travel next year",
                        options: ["We will travel next year", "We will travels next year", "We will traveling next year", "We will to travel next year"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson35,
                title: "Câu hỏi Wh-",
                description: "Who, What, Where, When, Why, How",
                level: 3,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "___ are you? - I'm fine, thanks",
                        correctAnswer: "How",
                        options: ["How", "What", "Who", "Where"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "___ is your name? - My name is Tom",
                        correctAnswer: "What",
                        options: ["What", "Who", "Where", "When"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "___ do you live? - In Hanoi",
                        correctAnswer: "Where"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "___ is your birthday? - In June",
                        correctAnswer: "When",
                        options: ["When", "What", "Why", "How"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Why are you late?'",
                        correctAnswer: "Tại sao bạn đến muộn"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "___ is that? - It's my friend",
                        correctAnswer: "Who",
                        options: ["Who", "What", "Where", "When"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "___ old are you? - I'm 10 years old",
                        correctAnswer: "How"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "___ do you go to school? - By bus",
                        correctAnswer: "How",
                        options: ["How", "What", "Where", "Who"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "___ color do you like? - I like blue",
                        correctAnswer: "What",
                        options: ["What", "Which", "How", "Why"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "___ is your teacher? - Ms. Smith",
                        correctAnswer: "Who"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Where is the library?'",
                        correctAnswer: "Thư viện ở đâu"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "___ do you like pizza? - Because it's delicious",
                        correctAnswer: "Why",
                        options: ["Why", "What", "When", "How"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson36,
                title: "Địa điểm trong thành phố",
                description: "Các địa điểm công cộng",
                level: 3,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Where do you buy medicine?",
                        correctAnswer: "pharmacy",
                        options: ["pharmacy", "library", "bank", "park"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'bưu điện' in English?",
                        correctAnswer: "post office",
                        options: ["post office", "police station", "hospital", "school"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I borrow books from the ___",
                        correctAnswer: "library"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'museum' mean?",
                        correctAnswer: "bảo tàng",
                        options: ["bảo tàng", "công viên", "ngân hàng", "bệnh viện"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The bank is next to the supermarket'",
                        correctAnswer: "Ngân hàng ở cạnh siêu thị"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Where do you see a doctor?",
                        correctAnswer: "hospital",
                        options: ["hospital", "library", "park", "mall"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I buy groceries at the ___",
                        correctAnswer: "supermarket"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'công viên' in English?",
                        correctAnswer: "park",
                        options: ["park", "garden", "zoo", "mall"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'police station' mean?",
                        correctAnswer: "đồn cảnh sát",
                        options: ["đồn cảnh sát", "bệnh viện", "trường học", "ngân hàng"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Children play at the ___",
                        correctAnswer: "playground"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The hotel is near the airport'",
                        correctAnswer: "Khách sạn gần sân bay"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Where do you go to watch movies?",
                        correctAnswer: "cinema",
                        options: ["cinema", "museum", "library", "park"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson37,
                title: "Đi mua sắm",
                description: "Từ vựng về mua sắm",
                level: 3,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you ask the price?",
                        correctAnswer: "How much is it?",
                        options: ["How much is it?", "What price?", "How many cost?", "What money?"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'giảm giá' in English?",
                        correctAnswer: "discount",
                        options: ["discount", "expensive", "cheap", "price"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Can I ___ this on? (for clothes)",
                        correctAnswer: "try"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'cash' mean?",
                        correctAnswer: "tiền mặt",
                        options: ["tiền mặt", "thẻ", "giảm giá", "đắt"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I'll take it'",
                        correctAnswer: "Tôi sẽ lấy nó"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you pay without cash?",
                        correctAnswer: "credit card",
                        options: ["credit card", "money", "coins", "bills"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "This shirt is too ___. I want a cheaper one",
                        correctAnswer: "expensive"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'rẻ' in English?",
                        correctAnswer: "cheap",
                        options: ["cheap", "expensive", "free", "costly"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'receipt' mean?",
                        correctAnswer: "hóa đơn",
                        options: ["hóa đơn", "tiền", "giá", "giảm giá"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Do you have this in a different ___?",
                        correctAnswer: "size"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'Can I get a refund?'",
                        correctAnswer: "Tôi có thể được hoàn tiền không"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you say when you want to buy something?",
                        correctAnswer: "I'll buy this",
                        options: ["I'll buy this", "Give me money", "You buy this", "I no want"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson38,
                title: "Sở thích",
                description: "Nói về sở thích của bạn",
                level: 3,
                xpReward: 20,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "What do you like to do in your free time?",
                        correctAnswer: "hobbies",
                        options: ["hobbies", "homework", "chores", "duties"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'vẽ' in English?",
                        correctAnswer: "draw",
                        options: ["draw", "paint", "write", "read"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I enjoy ___ music",
                        correctAnswer: "listening"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'collect stamps' mean?",
                        correctAnswer: "sưu tầm tem",
                        options: ["sưu tầm tem", "chơi game", "đọc sách", "xem phim"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'My hobby is playing guitar'",
                        correctAnswer: "Sở thích của tôi là chơi guitar"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What hobby involves books?",
                        correctAnswer: "reading",
                        options: ["reading", "swimming", "dancing", "cooking"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "I like ___ photos with my camera",
                        correctAnswer: "taking"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "How do you say 'nấu ăn' in English?",
                        correctAnswer: "cooking",
                        options: ["cooking", "eating", "baking", "serving"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What does 'gardening' mean?",
                        correctAnswer: "làm vườn",
                        options: ["làm vườn", "vẽ", "đọc", "chơi game"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "She enjoys ___ to music",
                        correctAnswer: "listening"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'I love dancing'",
                        correctAnswer: "Tôi thích nhảy"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Which is a creative hobby?",
                        correctAnswer: "painting",
                        options: ["painting", "sleeping", "eating", "walking"]
                    )
                ],
                isPremium: false
            ),

            Lesson(
                id: LessonID.lesson39,
                title: "Câu chuyện ngắn",
                description: "Đọc hiểu câu chuyện",
                level: 3,
                xpReward: 30,
                questions: [
                    Question(
                        type: .multipleChoice,
                        prompt: "Story: 'Tom went to the zoo. He saw lions and elephants.' Where did Tom go?",
                        correctAnswer: "zoo",
                        options: ["zoo", "park", "school", "home"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "What animals did Tom see?",
                        correctAnswer: "lions and elephants",
                        options: ["lions and elephants", "dogs and cats", "birds and fish", "monkeys and bears"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Story: 'Mary likes to ___. She reads every day.' What does Mary like?",
                        correctAnswer: "read"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Story: 'The cat is on the mat. The dog is under the table.' Where is the dog?",
                        correctAnswer: "under the table",
                        options: ["under the table", "on the mat", "in the box", "near the door"]
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate the story: 'I have a friend. His name is John.'",
                        correctAnswer: "Tôi có một người bạn. Tên anh ấy là John"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Story: 'Anna has a red bike. She rides it to school.' What color is Anna's bike?",
                        correctAnswer: "red",
                        options: ["red", "blue", "green", "yellow"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Story: 'The sun is shining. Birds are ___.' What are the birds doing?",
                        correctAnswer: "singing"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Story: 'Peter eats breakfast at 7 AM. Then he goes to school.' When does Peter eat breakfast?",
                        correctAnswer: "7 AM",
                        options: ["7 AM", "8 AM", "6 AM", "9 AM"]
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Story: 'My dog is black and white. He likes to play.' What does the dog like?",
                        correctAnswer: "to play",
                        options: ["to play", "to sleep", "to eat", "to run"]
                    ),
                    Question(
                        type: .fillInBlank,
                        prompt: "Story: 'Sarah has three ___. They are red, blue, and green.' What does Sarah have?",
                        correctAnswer: "pens"
                    ),
                    Question(
                        type: .translation,
                        prompt: "Translate: 'The boy is happy. He has a new toy.'",
                        correctAnswer: "Cậu bé vui vẻ. Cậu ấy có một đồ chơi mới"
                    ),
                    Question(
                        type: .multipleChoice,
                        prompt: "Story: 'It's raining today. Lisa takes her umbrella.' Why does Lisa take her umbrella?",
                        correctAnswer: "Because it's raining",
                        options: ["Because it's raining", "Because it's sunny", "Because it's cold", "Because it's hot"]
                    )
                ],
                isPremium: false
            )
        ]
    }

    /// Updates lesson lock status based on sequential progression
    /// - Parameter completedLessonIds: List of completed lesson IDs
    /// - Returns: Lessons with updated lock status
    func getlessonsWithLockStatus(completedLessonIds: [String]) -> [Lesson] {
        var lessons = getLessons()

        // First lesson is always unlocked
        if !lessons.isEmpty {
            lessons[0].isLocked = false
        }

        // For each subsequent lesson, check if previous lesson is completed
        for i in 1..<lessons.count {
            let previousLesson = lessons[i - 1]
            let isPreviousCompleted = completedLessonIds.contains(previousLesson.id.uuidString)

            // Lesson is locked if previous lesson is not completed
            lessons[i].isLocked = !isPreviousCompleted
        }

        return lessons
    }
}
