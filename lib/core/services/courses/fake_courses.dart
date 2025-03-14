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
                    Chapter(
                      id: "chapter${index + 1}_2",
                      name: "Chapter 2: Introduction to Course ${index + 1}",
                      sequence: 2,
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
                        ),
                      ),
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
      code: "200",
      msg: "success",
      data: course.Data(
        id: "1",
        workspaceId: "1",
        instructor: course.Instructor(
          id: "1",
          workspaceId: "1",
          title: "Dr.",
          firstName: "Instructor",
          lastName: "1",
          email: "instructor1@example.com",
          avatar: "https://randomuser.me/api/portraits/men/1.jpg",
          description: "Expert instructor with 10 years of experience",
        ),
        categories: [
          course.Category(
            id: "1",
            name: "Category 1",
            description: "Description for Category 1",
          ),
        ],
        title: "Course 1",
        subTitle: "Subtitle for Course 1",
        slug: "course-1",
        description: "Comprehensive course covering all aspects of Subject 1",
        thumbnail: course.Thumbnail(
          horizontal:
              "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
          vertical:
              "https://img5.pic.in.th/file/secure-sv1/Card53b396ceb9250c0c.png",
        ),
        cover:
            "https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/site/2148563173/images/345203-352c-8b52-3156-e3b4c1e1ed7_Artboard_3-100-11.jpg",
        journey: course.Journey(
          suitableFor: ["Beginners", "Intermediate Learners"],
          outcomes: ["Master 1 key concepts", "Build 1 projects"],
        ),
        chapters: [
          course.Chapter(
            id: "1",
            name: "Chapter 1",
            sequence: 1,
            lessons: [
              course.Lesson(
                id: "1",
                name: "Lesson 1 ชื่อสั้นๆ",
                isFree: true,
                sequence: 1,
                type: "video",
                content: course.Content(
                  video: course.Video(
                    id: "1",
                    assetId: "1",
                    name: "Video 1",
                    fileSize: 1024 * 1024 * 1,
                    duration: 60 * 1,
                    durationMs: 60000 * 1,
                    packType: "mp4",
                    codec: "h264",
                    audioCodec: "aac",
                    status: "ready",
                    url: "https://example.com/video1.mp4",
                  ),
                ),
              ),
            ],
          ),
          course.Chapter(
            id: "2",
            name: "Chapter 2",
            sequence: 2,
            lessons: [
              course.Lesson(
                id: "2",
                name: "Lesson 2",
                isFree: false,
                sequence: 1,
                type: "video",
                content: course.Content(
                  video: course.Video(
                    id: "2",
                    assetId: "2",
                    name: "Video 2",
                    fileSize: 1024 * 1024 * 2,
                    duration: 60 * 2,
                    durationMs: 60000 * 2,
                    packType: "mp4",
                    codec: "h264",
                    audioCodec: "aac",
                    status: "ready",
                    url: "https://example.com/video2.mp4",
                  ),
                ),
              ),
            ],
          ),
        ],
        rating: 4.5,
        status: "active",
        price: 99.99,
        isMastery: true,
        isFree: false,
        teaser: "Master new concepts in Course 1",
        releaseAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        joined: true,
        favorited: true,
        expiredAt: DateTime.now().add(Duration(days: 30)).toIso8601String(),
        isExpired: false,
      ),
    );
  }
}
