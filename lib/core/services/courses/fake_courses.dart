import 'package:edupluz_future/core/models/courses/courses_model.dart';

class FakeCourses {
  static CoursesModel getCourses() {
    return CoursesModel(
      code: "200",
      msg: "success",
      data: Data(
        items: List.generate(
            19,
            (index) => Item(
                  id: "course${index + 1}",
                  name: "Course ${index + 1}",
                  slug: "course-${index + 1}",
                  releaseAt: DateTime.now().subtract(Duration(days: index * 5)),
                  headline: "Learn amazing skills in Course ${index + 1}",
                  teaser: "Master new concepts in Course ${index + 1}",
                  views: 100 + (index * 50),
                  duration: 6120002 + (index * 30),
                  thumbnail: Thumbnail(
                    horizontal:
                        "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
                    vertical:
                        "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
                  ),
                  cover:
                      "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
                  description:
                      "Comprehensive course covering all aspects of Subject ${index + 1}",
                  instructor: Instructor(
                    title: index % 2 == 0 ? "Dr." : "Prof.",
                    firstName: "John${index + 1}",
                    lastName: "Doe${index + 1}",
                    avatar:
                        "https://scontent.fbkk8-2.fna.fbcdn.net/v/t39.30808-1/474675937_638007428786761_7194845901952792177_n.jpg?stp=dst-jpg_s480x480_tt6&_nc_cat=106&ccb=1-7&_nc_sid=2d3e12&_nc_eui2=AeHbLqXzUWX9r60_H786ogyr9yAOKcZwMAX3IA4pxnAwBWddGAywFwfO5RtU_PrYY6etDQ5-j47qKSY7txnTOJVB&_nc_ohc=z6-3UGQ0T5QQ7kNvgGzyApy&_nc_oc=AdhOgIAOH1ZwUTAgR1dKbvLIOT0v8uqq2U9LCYjgsxgVri7534vr9Gv6BCccR83LXyo&_nc_zt=24&_nc_ht=scontent.fbkk8-2.fna&_nc_gid=Ay20KPyfeZBwAbNwoUZKsVS&oh=00_AYAUQXlbyBtKj44BWAAXncnrJj7xvot3oCLcvtiwihILTQ&oe=67B8D803",
                    description:
                        "Expert instructor with ${10 + index} years of experience",
                  ),
                  categories: [
                    "Category${index % 5 + 1}",
                    "Skills${index % 3 + 1}"
                  ],
                  promotions:
                      index % 3 == 0 ? ["Special Offer", "Early Bird"] : [],
                  joined: index % 2 == 0,
                  favorited: index % 3 == 0,
                  mastery: index % 4 == 0,
                  status: index % 5 == 0 ? "upcoming" : "active",
                  rating: (3.5 + (index % 3) * 0.5).round(),
                  price: (99.99 + (index * 20)).round(),
                  discount: index % 2 == 0 ? 15 : 0,
                  netPrice:
                      ((99.99 + (index * 20)) * (index % 2 == 0 ? 0.85 : 1))
                          .round(),
                  journey: Journey(
                    suitableFor: ["Beginners", "Intermediate Learners"],
                    outcomes: [
                      "Master ${index + 1} key concepts",
                      "Build ${index + 1} projects"
                    ],
                  ),
                  progress: index % 2 == 0 ? 100 : (index * 10) % 100,
                  business: index % 3 == 0,
                  chapters: [
                    Chapter(
                      sequence: 1,
                      lessons: List.generate(
                          3,
                          (lessonIndex) => Lesson(
                                id: "${index + 1}_${lessonIndex + 1}",
                                name: "Lesson ${lessonIndex + 1}",
                                duration: 20 + (lessonIndex * 10),
                                type: Type.VIDEO,
                                free: lessonIndex == 0,
                                sequence: lessonIndex + 1,
                                watched: index % 2 == 0,
                              )),
                      duration: 90,
                      id: "chapter${index + 1}_1",
                      name: "Chapter 1: Introduction to Course ${index + 1}",
                    ),
                  ],
                  itemContinue: Continue(
                    name: "Continue with Lesson ${index % 3 + 1}",
                    sequence: index % 3 + 1,
                    chapterId: "chapter${index + 1}_1",
                    lessonId: "${index + 1}_${index % 3 + 1}",
                    progress: index % 2 == 0 ? 100 : (index * 10) % 100,
                    duration: 30 + (index * 5),
                  ),
                )),
        meta: Meta(
          itemCount: 19,
          totalItems: 19,
          page: 1,
          limit: 20,
          totalPages: 1,
        ),
      ),
    );
  }
}
