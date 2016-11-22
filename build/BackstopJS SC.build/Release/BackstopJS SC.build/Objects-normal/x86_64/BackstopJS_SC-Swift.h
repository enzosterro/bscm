// Generated by Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import AppKit;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSApplication;

SWIFT_CLASS("_TtC13BackstopJS_SC11AppDelegate")
@interface AppDelegate : NSObject <NSApplicationDelegate>
- (void)applicationDidFinishLaunching:(NSNotification * _Nonnull)aNotification;
- (void)applicationWillTerminate:(NSNotification * _Nonnull)aNotification;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication * _Nonnull)sender;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSXMLParser;

/**
  The implementation of XMLParserDelegate and where the parsing actually happens.
*/
SWIFT_CLASS("_TtC13BackstopJS_SC13FullXMLParser")
@interface FullXMLParser : NSObject <NSXMLParserDelegate>
- (void)parser:(NSXMLParser * _Nonnull)parser didStartElement:(NSString * _Nonnull)elementName namespaceURI:(NSString * _Nullable)namespaceURI qualifiedName:(NSString * _Nullable)qName attributes:(NSDictionary<NSString *, NSString *> * _Nonnull)attributeDict;
- (void)parser:(NSXMLParser * _Nonnull)parser foundCharacters:(NSString * _Nonnull)string;
- (void)parser:(NSXMLParser * _Nonnull)parser didEndElement:(NSString * _Nonnull)elementName namespaceURI:(NSString * _Nullable)namespaceURI qualifiedName:(NSString * _Nullable)qName;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/**
  The implementation of XMLParserDelegate and where the lazy parsing actually happens.
*/
SWIFT_CLASS("_TtC13BackstopJS_SC13LazyXMLParser")
@interface LazyXMLParser : NSObject <NSXMLParserDelegate>
@property (nonatomic, copy) NSData * _Nullable data;
- (void)parser:(NSXMLParser * _Nonnull)parser didStartElement:(NSString * _Nonnull)elementName namespaceURI:(NSString * _Nullable)namespaceURI qualifiedName:(NSString * _Nullable)qName attributes:(NSDictionary<NSString *, NSString *> * _Nonnull)attributeDict;
- (void)parser:(NSXMLParser * _Nonnull)parser foundCharacters:(NSString * _Nonnull)string;
- (void)parser:(NSXMLParser * _Nonnull)parser didEndElement:(NSString * _Nonnull)elementName namespaceURI:(NSString * _Nullable)namespaceURI qualifiedName:(NSString * _Nullable)qName;
- (BOOL)onMatch;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class NSButton;
@class NSTextField;
@class NSComboBox;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC13BackstopJS_SC14ViewController")
@interface ViewController : NSViewController
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified urlTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified delayTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified selectorsTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified hideSelectorsTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified removeSelectorsTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified onBeforeScriptTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified onReadyScriptTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified readyEventTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified misMatchThresholdTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified bitmapsReferenceTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified bitmapsTestTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified compareDataTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified casperScriptsTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified casperFlagsTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified engineTextField;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified reportTextField;
@property (nonatomic, weak) IBOutlet NSComboBox * _Null_unspecified debugComboBox;
@property (nonatomic, weak) IBOutlet NSTextField * _Null_unspecified portTextField;
@property (nonatomic, weak) IBOutlet NSButton * _Null_unspecified viewPortPhone;
@property (nonatomic, weak) IBOutlet NSButton * _Null_unspecified viewPortTabletF;
@property (nonatomic, weak) IBOutlet NSButton * _Null_unspecified viewPortTabletV;
@property (nonatomic, weak) IBOutlet NSButton * _Null_unspecified viewPortTabletH;
- (IBAction)makeScenarioButtonPressed:(NSButton * _Nonnull)sender;
- (NSArray<NSString *> * _Nonnull)xmlToArray:(NSString * _Nonnull)inXml;
- (NSDictionary<NSString *, id> * _Nonnull)makeScenario:(NSArray<NSString *> * _Nonnull)arrayOfLinks;
- (NSString * _Nonnull)trimDestinationPart:(NSString * _Null_unspecified)regex text:(NSString * _Null_unspecified)text;
- (BOOL)dialogOKCancel:(NSString * _Nonnull)question text:(NSString * _Nonnull)text cancelButton:(BOOL)cancelButton;
- (void)viewDidLoad;
@property (nonatomic) id _Nullable representedObject;
- (nullable instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
