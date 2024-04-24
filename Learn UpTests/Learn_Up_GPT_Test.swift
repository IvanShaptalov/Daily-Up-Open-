//
//  Learn_Up_GPT_Test.swift
//  Learn UpTests
//
//  Created by PowerMac on 10.01.2024.
//


import XCTest
@testable import Learn_Up

extension Learn_UpTests {
    
    
    // MARK: - Test Raw
    
    func testKeys() throws {
        XCTAssertGreaterThan(LearnUpConfiguration.gptToken.count, 10)
        XCTAssertGreaterThan(LearnUpConfiguration.gptOrganization.count, 0)
    }
    
    func testRequest() throws {
        
        var myResponse = RawResponse(response: "", code: 404)
        
        OpenAIApi.request(RawRequest(raw: "translate sakartvelo from English to Russian. give answer in this format: translation: word translation| meaning: meaning in English"), rawCompletion: {response in
            XCTAssertEqual(response.code, 200)
            myResponse = response as! RawResponse
            print(response.response)
        })
                
        sleep(10)
        
        XCTAssertEqual(myResponse.code, 200)
        NSLog(myResponse.response)
    }
    
    func testFillWord() throws {
        var myResponse = WordFillerResponse()

        WordFiller.fillWord(WordFillerRequest(word: "hello", toLang: .Ukrainian, fromLang: .English), fillerCompletion: {response in
            NSLog("enter fillWord completion")
            NSLog(response.translation)
            
            XCTAssertTrue(response.translation.contains("привіт") || response.translation.contains("топор"))
            myResponse = response as! WordFillerResponse
        })
        sleep(10)
        XCTAssertNotEqual(myResponse.meaning, "default")
    }
    
  
    func testGptSwitch(){
        XCTAssert(LearnUpConfiguration.gptModel == "gpt-3.5-turbo-1106")
        LearnUpConfiguration.switchGptModel()
        
        XCTAssert(LearnUpConfiguration.gptModel == "gpt-3.5-turbo-0301")
        
        LearnUpConfiguration.switchGptModel()
        LearnUpConfiguration.switchGptModel()
        XCTAssert(LearnUpConfiguration.gptModel == "gpt-3.5-turbo-0613")
    }
    
    
    
}


