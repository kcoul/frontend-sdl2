add_library(libprojectM::projectM SHARED IMPORTED)
add_library(libprojectM::playlist SHARED IMPORTED)

# TODO: Make into Multi-config generator expression

#message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Release-iphoneos/libprojectM-4.dylib")
#message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Release-iphoneos/libprojectM-4-playlist.dylib")

message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Debug-iphoneos/libprojectM-4d.dylib")
message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Debug-iphoneos/libprojectM-4-playlistd.dylib")

#set_property(TARGET libprojectM::projectM PROPERTY
#        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Release-iphoneos/libprojectM-4.dylib")
#set_property(TARGET libprojectM::playlist PROPERTY
#        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Release-iphoneos/libprojectM-4-playlist.dylib")

set_property(TARGET libprojectM::projectM PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4/iOS-arm64/Debug-iphoneos/libprojectM-4d.dylib")
set_property(TARGET libprojectM::playlist PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/projectM4-playlist/iOS-arm64/Debug-iphoneos/libprojectM-4-playlistd.dylib")

