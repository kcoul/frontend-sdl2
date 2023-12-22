add_library(Poco::Util SHARED IMPORTED)
add_library(Poco::Foundation SHARED IMPORTED)
#Deps
add_library(Poco::JSON SHARED IMPORTED)
add_library(Poco::XML SHARED IMPORTED)

message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoUtil.dylib")
message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoFoundation.dylib")
message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoJSON.dylib")
message("Using ${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoXML.dylib")

set_property(TARGET Poco::Util PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoUtil.dylib")
set_property(TARGET Poco::Foundation PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoFoundation.dylib")
set_property(TARGET Poco::JSON PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoJSON.dylib")
set_property(TARGET Poco::XML PROPERTY
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/libs/poco/iOS-arm64/libPocoXML.dylib")