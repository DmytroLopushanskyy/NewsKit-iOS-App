//
//  Decryption.swift
//  NewsKit-iOS-App
//
//  Created by Дмитро Лопушанський on 10/7/19.
//
import CryptoSwift
let salt_key = "key2019odododUCU"
let salt_iv = "odonewskitsecret"

func generateHash(for stringName: String) throws -> String {
    print("here1!")
    let aes = try AES(key: salt_key, iv: salt_iv)
    let ciphertext = try aes.encrypt(Array(stringName.utf8))
    print("here!")
    return ciphertext.toHexString()
}

func decodeHash(for stringName: String) throws -> String {
    let aes = try AES(key: salt_key, iv: salt_iv)
    let myUInt = Array(Data(hex: stringName))
    let decrypted = try aes.decrypt(Array(myUInt))
    let string = String(bytes: decrypted, encoding: .utf8) ?? ""
    return string
}
