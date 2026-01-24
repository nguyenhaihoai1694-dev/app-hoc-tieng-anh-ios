import Foundation

class LessonDataService {
    static let shared = LessonDataService()

    private init() {}

    func getLessons() -> [Lesson] {
        return [
            // Beginner Lessons (Free)
            Lesson(
                title: "Chào hỏi cơ bản",
                description: "Học cách chào hỏi trong tiếng Anh",
                level: 1,
                xpReward: 10,
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
                title: "Giới thiệu bản thân",
                description: "Học cách tự giới thiệu",
                level: 1,
                xpReward: 15,
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
                    )
                ],
                isPremium: false
            ),

            Lesson(
                title: "Số đếm 1-20",
                description: "Học đếm số từ 1 đến 20",
                level: 1,
                xpReward: 10,
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
                    )
                ],
                isPremium: false
            ),

            // Intermediate Lessons (Premium)
            Lesson(
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
                isPremium: true
            ),

            Lesson(
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
                isPremium: true
            ),

            Lesson(
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
                isPremium: true
            ),

            Lesson(
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
                isPremium: true
            ),

            Lesson(
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
                isPremium: true
            )
        ]
    }
}
