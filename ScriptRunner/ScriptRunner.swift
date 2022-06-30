//
//  ScriptRunner.swift
//  ScriptRunner
//
//  Created by Grande, Christopher A on 6/29/22.
//

import ArgumentParser
import Foundation


@main
struct ScriptRunner: ParsableCommand {
    @Flag(help: "Checks if the script is in list of known scripts")
    var checkMD5 = false
    
    @Flag(help: "Prints the MD5 of the script.")
    var printMD5 = false
    
    @Option(help: "The interpreter to use, i.e. your Python.")
    var interpreter: String

    @Option(help: "Path to the script you are trying to run")
    var scriptPath: String

    mutating func run() throws {
        print("Use \(interpreter) to run \(scriptPath)")
    
        // return script as string
        let script = try String(contentsOfFile: scriptPath)
        let scriptMD5 = script.MD5

        
        if printMD5 {
            print("MD5: \(scriptMD5)")
        }
        
        if checkMD5 {
            if knownScripts.contains(scriptMD5){
                print("Script is in known list.")
            } else {
                print("Script is unknown.")
            }
        }
        
        if checkMD5 || printMD5 {
            ScriptRunner.exit()
        }
        
        // if the md5 is in the known scripts array, run the script
        if knownScripts.contains(scriptMD5) {
            print("Script is known, running...")
            let script = Process()
            script.launchPath = interpreter
            script.arguments = [scriptPath]
            script.launch()
            script.waitUntilExit()
        } else {
            print("Script is unknown, not running...")
            ScriptRunner.exit()
        }

       
    }
}
