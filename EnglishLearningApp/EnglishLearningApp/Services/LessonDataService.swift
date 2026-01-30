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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
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
