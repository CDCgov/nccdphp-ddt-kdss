Imports System.Security.Cryptography
Imports System.IO
Imports System.Text

Public Class cryptor


    Public Shared Function EncryptString(ByVal plainText As String) As String

        Dim passPhrase As String = "cdcckd"
        Dim initVector As String = "ckdsurveillance!"
        Dim keysize As Integer = 256


        Dim initVectorBytes() As Byte = Encoding.UTF8.GetBytes(initVector)
        Dim plainTextBytes() As Byte = Encoding.UTF8.GetBytes(plainText)
        Dim password As PasswordDeriveBytes = New PasswordDeriveBytes(passPhrase, Nothing)
        Dim keyBytes() As Byte = password.GetBytes(keysize / 8)
        Dim symmetricKey As New RijndaelManaged()
        symmetricKey.Mode = CipherMode.CBC
        Dim encryptor As ICryptoTransform = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes)
        Dim memStream As New MemoryStream()

        Dim cryptStream As New CryptoStream(memStream, encryptor, CryptoStreamMode.Write)
        With cryptStream
            .Write(plainTextBytes, 0, plainTextBytes.Length)
            .FlushFinalBlock()
        End With
        
        Dim cypherTextBytes() As Byte = memStream.ToArray()
        memStream.Close()
        cryptStream.Close()

        Return Convert.ToBase64String(cypherTextBytes)

    End Function

    Public Shared Function DecryptString(ByVal cypherText As String) As String

        Dim passPhrase As String = "cdcckd"
        Dim initVector As String = "ckdsurveillance!"
        Dim keysize As Integer = 256


        Dim initVectorBytes() As Byte = Encoding.ASCII.GetBytes(initVector)
        Dim cipherTextBytes() As Byte = Convert.FromBase64String(cypherText)
        Dim password As New PasswordDeriveBytes(passPhrase, Nothing)
        Dim keyBytes() As Byte = password.GetBytes(keysize / 8)
        Dim symmetricKey As New RijndaelManaged()
        symmetricKey.Mode = CipherMode.CBC
        Dim decryptor As ICryptoTransform = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes)

        Dim memStream As New MemoryStream(cipherTextBytes)

        Dim cryptStream As New CryptoStream(memStream, decryptor, CryptoStreamMode.Read)
        Dim plainTextBytes(cipherTextBytes.Length) As Byte
        Dim decryptedByteCount As Integer = cryptStream.Read(plainTextBytes, 0, plainTextBytes.Length)

        memStream.Close()
        cryptStream.Close()

        Return Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount)

    End Function

End Class
