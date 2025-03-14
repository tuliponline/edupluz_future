import 'package:edupluz_future/core/models/courses/course_model.dart' as course;
import 'package:edupluz_future/core/models/courses/courses_model.dart';

class FakeCourses {
  static CoursesModel getCourses({int count = 19}) {
    return CoursesModel(
      code: "200",
      msg: "success",
      data: Data(
        items: List.generate(
            count,
            (index) => Item(
                  id: "course${index + 1}",
                  workspaceId: "workspace${index + 1}",
                  instructor: Instructor(
                    id: "instructor${index + 1}",
                    workspaceId: "workspace${index + 1}",
                    title: "Dr.",
                    firstName: "Instructor",
                    lastName: "${index + 1}",
                    email: "instructor${index + 1}@example.com",
                    avatar:
                        "https://randomuser.me/api/portraits/men/${index + 1}.jpg",
                    description:
                        "Expert instructor with ${index + 5} years of experience",
                  ),
                  categories: [
                    Category(
                        id: "cat${index % 5 + 1}",
                        name: "Category${index % 5 + 1}",
                        description: "Description for Category${index % 5 + 1}")
                  ],
                  title: "Course ${index + 1}",
                  subTitle: "Subtitle for Course ${index + 1}",
                  slug: "course-${index + 1}",
                  description:
                      "Comprehensive course covering all aspects of Subject ${index + 1}",
                  thumbnail: Thumbnail(
                    horizontal:
                        "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
                    vertical:
                        "https://img5.pic.in.th/file/secure-sv1/Card53b396ceb9250c0c.png",
                  ),
                  cover:
                      "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
                  journey: Journey(
                    suitableFor: ["Beginners", "Intermediate Learners"],
                    outcomes: [
                      "Master ${index + 1} key concepts",
                      "Build ${index + 1} projects"
                    ],
                  ),
                  chapters: [
                    Chapter(
                      id: "chapter${index + 1}_1",
                      name: "Chapter 1: Introduction to Course ${index + 1}",
                      sequence: 1,
                      lessons: List.generate(
                          3,
                          (lessonIndex) => Lesson(
                                id: "${index + 1}_${lessonIndex + 1}",
                                type: Type.VIDEO,
                                name: "Lesson ${lessonIndex + 1}",
                                isFree: lessonIndex == 0,
                                sequence: lessonIndex + 1,
                                content: Content(
                                  video: Video(
                                    id: "video${lessonIndex + 1}",
                                    assetId: "asset${lessonIndex + 1}",
                                    name: "Video ${lessonIndex + 1}",
                                    fileSize: 1024 * 1024 * (lessonIndex + 1),
                                    duration: 60 * (lessonIndex + 1),
                                    durationMs: 60000 * (lessonIndex + 1),
                                    packType: "mp4",
                                    codec: "h264",
                                    audioCodec: "aac",
                                    status: "ready",
                                    url:
                                        "https://example.com/video${lessonIndex + 1}.mp4",
                                  ),
                                ),
                              )),
                    ),
                  ],
                  rating: (3.5 + (index % 3) * 0.5).toDouble(),
                  status: index % 5 == 0 ? "upcoming" : "active",
                  price: (99.99 + (index * 20)).toDouble(),
                  isMastery: index % 4 == 0,
                  isFree: index % 2 == 0,
                  teaser: "Master new concepts in Course ${index + 1}",
                  releaseAt: DateTime.now().subtract(Duration(days: index * 5)),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  joined: index % 3 == 0,
                  favorited: index % 4 == 0,
                  expiredAt: DateTime.now()
                      .add(Duration(days: 30 * (index + 1)))
                      .toIso8601String(),
                  isExpired: false,
                )),
        meta: Meta(
          itemCount: count,
          totalItems: count,
          page: 1,
          limit: 20,
          totalPages: (count / 20).ceil(),
        ),
      ),
    );
  }

  static course.CourseModel courseById() {
    return course.CourseModel(
      id: "1",
      name: "Course 1",
      slug: "course-1",
      teaser: "Master new concepts in Course 1",
      views: 100,
      duration: 6120002,
      thumbnail: course.Thumbnail(
        horizontal:
            "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
        vertical:
            "https://img5.pic.in.th/file/secure-sv1/Card53b396ceb9250c0c.png",
      ),
      cover:
          "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
      description: "Comprehensive course covering all aspects of Subject 1",
      instructor: course.Instructor(
        title: "Dr.",
        firstName: "John",
        lastName: "Doe",
        avatar:
            "https://scontent.fbkk8-2.fna.fbcdn.net/v/t39.30808-1/474675937_638007428786761_7194845901952792177_n.jpg?stp=dst-jpg_s480x480_tt6&_nc_cat=106&ccb=1-7&_nc_sid=2d3e12&_nc_eui2=AeHbLqXzUWX9r60_H786ogyr9yAOKcZwMAX3IA4pxnAwBWddGAywFwfO5RtU_PrYY6etDQ5-j47qKSY7txnTOJVB&_nc_ohc=z6-3UGQ0T5QQ7kNvgGzyApy&_nc_oc=AdhOgIAOH1ZwUTAgR1dKbvLIOT0v8uqq2U9LCYjgsxgVri7534vr9Gv6BCccR83LXyo&_nc_zt=24&_nc_ht=scontent.fbkk8-2.fna&_nc_gid=Ay20KPyfeZBwAbNwoUZKsVS&oh=00_AYAUQXlbyBtKj44BWAAXncnrJj7xvot3oCLcvtiwihILTQ&oe=67B8D803",
        description: "Expert instructor with 10 years of experience",
      ),
      categories: ["Category 1", "Category 2"],
      promotions: ["Promotion 1", "Promotion 2"],
      joined: true,
      favorited: true,
      mastery: true,
      status: "active",
      rating: 4,
      price: 100,
      discount: 10,
      netPrice: 90,
      journey: course.Journey(
        suitableFor: ["Beginners", "Intermediate Learners"],
        outcomes: ["Outcome 1", "Outcome 2"],
      ),
      progress: 50,
      business: true,
      chapters: [
        course.Chapter(
          id: "chapter1",
          name: "Introduction",
          sequence: 1,
          lessons: [
            course.Lesson(
              id: "lesson1",
              name: "Introduction",
              duration: 2120002,
              type: "video",
              free: true,
              sequence: 1,
              watched: true,
            ),
          ],
          duration: 90,
        ),
        course.Chapter(
          id: "chapter2",
          name: "Chapter 2",
          sequence: 2,
          lessons: [
            course.Lesson(
              id: "lesson2",
              name: "Lesson 2",
              duration: 3120002,
              type: "video",
              free: false,
              sequence: 1,
              watched: true,
            ),
          ],
          duration: 0,
        ),
        course.Chapter(
          id: "chapter3",
          name: "Chapter 3",
          sequence: 3,
          lessons: [
            course.Lesson(
              id: "lesson3",
              name: "Lesson 3",
              duration: 1120002,
              type: "video",
              free: false,
              sequence: 1,
              watched: true,
            ),
          ],
          duration: 0,
        ),
      ],
      courseModelContinue: course.Continue(
        name: "Continue with Lesson 1",
        sequence: 1,
        chapterId: "chapter1",
        lessonId: "lesson1",
        progress: 50,
        duration: 20,
      ),
    );
  }
}
