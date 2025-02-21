data class response(
    val copyright: String,
    val response: ResponseX,
    val status: String
){
    data class ResponseX(
        val docs: List<Doc>,
        val meta: Meta
    )
    data class Legacy(
        val thumbnail: String,
        val thumbnailheight: Int,
        val thumbnailwidth: Int,
        val wide: String,
        val wideheight: Int,
        val widewidth: Int,
        val xlarge: String,
        val xlargeheight: Int,
        val xlargewidth: Int
    )
    data class Meta(
        val hits: Int,
        val offset: Int,
        val time: Int
    )
    data class Multimedia(
        val caption: Any,
        val credit: Any,
        val crop_name: String,
        val height: Int,
        val legacy: Legacy,
        val rank: Int,
        val subType: String,
        val subtype: String,
        val type: String,
        val url: String,
        val width: Int
    )
    data class Person(
        val firstname: String,
        val lastname: String,
        val middlename: String,
        val organization: String,
        val qualifier: Any,
        val rank: Int,
        val role: String,
        val title: Any
    )

    data class Byline(
        val organization: Any,
        val original: String,
        val person: List<Person>
    )
    data class Doc(
        val _id: String,
        val `abstract`: String,
        val byline: Byline,
        val document_type: String,
        val headline: Headline,
        val keywords: List<Keyword>,
        val lead_paragraph: String,
        val multimedia: List<Multimedia>,
        val news_desk: String,
        val print_page: String,
        val print_section: String,
        val pub_date: String,
        val section_name: String,
        val snippet: String,
        val source: String,
        val subsection_name: String,
        val type_of_material: String,
        val uri: String,
        val web_url: String,
        val word_count: Int
    )
    data class Headline(
        val content_kicker: Any,
        val kicker: Any,
        val main: String,
        val name: Any,
        val print_headline: String,
        val seo: Any,
        val sub: Any
    )
    data class Keyword(
        val major: String,
        val name: String,
        val rank: Int,
        val value: String
    )


}