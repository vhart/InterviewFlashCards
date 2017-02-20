class Flashcard {
    let question: String
    let answer: String?
    let questionImageUrl: String?
    let answerImageUrls: [String] = []
    private(set) var questionImages: [UIImage] = []
    private(set) var answerImages: [UIImage] = []
    
    private(set) var hasLoadedQuestionImages: Bool = false
    private(set) var hasLoadedAnswerImages: Bool = false
    
    
    public init?(dictionary dict: [String: Any]) {
        
        
        
        return nil
    }
    
    open func prepare(completion: (() -> Void)) {
        
    }
    
    class func flashcards(fromDictionaries dictionaries: [[String: Any]]) -> [Flashcard] {
        
    }
    
}
/*
 
 self.question         = dict[@"question"];
 self.answer           = dict[@"answer"];
 self.questionImageURL = dict[@"question_url"];
 
 id urls    = dict[@"answer_urls"];
 if ([urls isKindOfClass:[NSArray class]]) {
 self.answerImageURLs = urls;
 } else if ([urls isKindOfClass:[NSDictionary class]]) {
 self.answerImageURLs = [self arrayOfUrlsFromDictionary:urls];
 }
 self.questionImages = [NSArray new];
 
 self.answerImages = [NSArray new];
 }
 return self;
 }
 
 - (NSArray *)arrayOfUrlsFromDictionary:(NSDictionary *)urlDict {
 
 if (urlDict) {
 NSMutableArray *urlArray = [NSMutableArray arrayWithSize:urlDict.allKeys.count];
 
 for (NSString *key in urlDict) {
 [urlArray replaceObjectAtIndex:[key integerValue] withObject:urlDict[key]];
 }
 
 return urlArray;
 }
 
 return nil;
 }
 
 - (void)prepareFlashCardWithCompletion:(void (^)())completion{
 
 if (self.questionImageURL && self.questionImages.count == 0) {
 [UIImage asyncFetchForUrl:self.questionImageURL withCompletion:^(UIImage *img, BOOL success) {
 self.questionImages = [self.questionImages arrayByAddingObject:img];
 self.questionImagesLoaded = YES;
 if (self.answerImagesLoaded) {
 dispatch_async(dispatch_get_main_queue(), ^{
 completion();
 });
 }
 }];
 } else{
 self.questionImagesLoaded = YES;
 }
 
 if (self.answerImageURLs && self.answerImages.count == 0){
 dispatch_queue_t serial = dispatch_queue_create("com.answers.IFC", DISPATCH_QUEUE_SERIAL);
 for (NSString *url in self.answerImageURLs) {
 dispatch_async(serial, ^{
 
 NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
 UIImage *ansImage = [UIImage imageWithData:data];
 self.answerImages = [self.answerImages arrayByAddingObject:ansImage];
 
 if (self.answerImages.count == self.answerImageURLs.count) {
 self.answerImagesLoaded = YES;
 dispatch_async(dispatch_get_main_queue(), ^{
 completion();
 });
 }
 });
 }
 } else {
 self.answerImagesLoaded = YES;
 if (self.questionImagesLoaded) {
 if (NSThread.isMainThread) {
 completion();
 } else {
 dispatch_async(dispatch_get_main_queue(), ^{
 completion();
 });
 }
 }
 }
 }
 
 + (NSArray<IFCFlashCard *> *)flashCardsFromDictionaries:(NSArray<NSDictionary *> *)dictionaries{
 NSMutableArray <IFCFlashCard *> *flashCards = [NSMutableArray new];
 
 for (NSDictionary *dict in dictionaries) {
 IFCFlashCard *next = [[IFCFlashCard alloc] initWithDictionary:dict];
 [flashCards addObject:next];
 }
 
 return flashCards.copy;
 }

 */
