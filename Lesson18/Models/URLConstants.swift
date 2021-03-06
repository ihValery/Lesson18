import Foundation

struct URLConstants
{
    private static let urlDomain = "https://jsonplaceholder.typicode.com"
    
    static let urlUsers = "\(URLConstants.urlDomain)/users"
    static let urlAlbums = "\(URLConstants.urlDomain)/albums?userId="
    static let urlPhotos = "\(URLConstants.urlDomain)/photos?albumId="
    static let urlPosts = "\(URLConstants.urlDomain)/posts?userId="
    static let urlComments = "\(URLConstants.urlDomain)/posts"
    
    static let urlBigImage = "https://cdn.wallscloud.net/converted/1199453145-priroda-Lw1p-7680x4320-MM-100.jpg"
}
