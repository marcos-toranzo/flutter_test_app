import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_form/email_form_field.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_form/password_form_field.dart';
import 'package:flutter_test_app/widgets/buttons/wide_button.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_test_app/main.dart' as app;

const _bookCategoriesResults = {
  'Fiction': '''{
    "kind": "books#volumes",
    "totalItems": 2614,
    "items": [
        {
            "kind": "books#volume",
            "id": "PaPuCa3Yk08C",
            "etag": "6OcXqrw0dbg",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/PaPuCa3Yk08C",
            "volumeInfo": {
                "title": "Challenging Realities: Magic Realism in Contemporary American Women’s Fiction",
                "authors": [
                    "M. Ruth Noriega Sánchez"
                ],
                "publisher": "Universitat de València",
                "publishedDate": "2002",
                "description": "Las raíces del realismo mágico en los escritos de Borges y otros autores de América Latina han sido ampliamente reconocidos y bien documentadas produciendo una serie de estudios críticos, muchos de los cuales figuran en la bibliografía de este trabajo. Dentro de este marco, este libro presenta a los lectores una variedad de escritoras de grupos étnicos, conocidas y menos conocidas, y las coloca en un contexto literario en el que se tratan tanto a nivel individual como escritoras así como a nivel colectivo como parte de un movimiento artístico más amplio. Este libro es el resultado del trabajo realizado en las universidades de Sheffield y la de València y representa una valiosa investigación y una importante contribución a los estudios literarios.",
                "industryIdentifiers": [
                    {
                        "type": "ISBN_10",
                        "identifier": "8437054222"
                    },
                    {
                        "type": "ISBN_13",
                        "identifier": "9788437054223"
                    }
                ],
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 214,
                "printType": "BOOK",
                "categories": [
                    "Social Science"
                ],
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "0.2.3.0.preview.1",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=PaPuCa3Yk08C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=PaPuCa3Yk08C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=PaPuCa3Yk08C&pg=PA200&dq=Fiction&hl=&cd=1&source=gbs_api",
                "infoLink": "http://books.google.es/books?id=PaPuCa3Yk08C&dq=Fiction&hl=&source=gbs_api",
                "canonicalVolumeLink": "https://books.google.com/books/about/Challenging_Realities_Magic_Realism_in_C.html?hl=&id=PaPuCa3Yk08C"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "NOT_FOR_SALE",
                "isEbook": false
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "PARTIAL",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false
                },
                "pdf": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.es/books/download/Challenging_Realities_Magic_Realism_in_C-sample-pdf.acsm?id=PaPuCa3Yk08C&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "webReaderLink": "http://play.google.com/books/reader?id=PaPuCa3Yk08C&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "Ortega , Julio , ed . , Gabriel García Márquez and the Powers of <b>Fiction</b> ( Austin : University Texas Press , 1988 ) Owens , Louis , Other Destinies . Understanding the American Indian Novel ( Norman and London : University Oklahoma&nbsp;..."
            }
        }
      ]
    }''',
  'Sports': '''{
    "kind": "books#volumes",
    "totalItems": 999,
    "items": [
        {
            "kind": "books#volume",
            "id": "gIVhDwAAQBAJ",
            "etag": "ApGOusQH2CU",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/gIVhDwAAQBAJ",
            "volumeInfo": {
                "title": "Mujeres en los deportes (Women in Sports)",
                "authors": [
                    "Katie Kawa"
                ],
                "publisher": "The Rosen Publishing Group, Inc",
                "publishedDate": "2015-07-15",
                "description": "Go for the goal with this text, which examines fascinating female sports heroes who’ve proved to the world that gender is no barrier to athletic success. Readers will delight in learning about the lives of Mia Hamm, Wilma Rudolph, and the Williams sisters, as well as other important women who’ve broken barriers in sports. Readers will be inspired to pursue a career in athletics after learning about how others have achieved success in spite of great obstacles. The biographical nature of the text supports social studies curricula, and fact boxes and a comprehensive timeline provide opportunities for additional learning.",
                "industryIdentifiers": [
                    {
                        "type": "ISBN_13",
                        "identifier": "9781499405187"
                    },
                    {
                        "type": "ISBN_10",
                        "identifier": "1499405189"
                    }
                ],
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 34,
                "printType": "BOOK",
                "categories": [
                    "Juvenile Nonfiction"
                ],
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "preview-1.0.0",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=gIVhDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=gIVhDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=gIVhDwAAQBAJ&pg=PA2&dq=Sports&hl=&cd=1&source=gbs_api",
                "infoLink": "http://books.google.es/books?id=gIVhDwAAQBAJ&dq=Sports&hl=&source=gbs_api",
                "canonicalVolumeLink": "https://books.google.com/books/about/Mujeres_en_los_deportes_Women_in_Sports.html?hl=&id=gIVhDwAAQBAJ"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "NOT_FOR_SALE",
                "isEbook": false
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "PARTIAL",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false
                },
                "pdf": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.es/books/download/Mujeres_en_los_deportes_Women_in_Sports-sample-pdf.acsm?id=gIVhDwAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "webReaderLink": "http://play.google.com/books/reader?id=gIVhDwAAQBAJ&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "5 Al Tielemans/<b>Sports</b> Illustrated/ Getty Images; p. 6 Scott Halleran/Getty Images <b>Sport</b>/Getty Images; p. 7 New York Daily News Archive/ New York Daily News/Getty Images; p. 9 Mark Kauffman/The LIFE Images Collection/Getty Images; p."
            }
        }
    ]
}''',
  'Poetry': '''{
    "kind": "books#volumes",
    "totalItems": 871,
    "items": [
        {
            "kind": "books#volume",
            "id": "DDTdDwAAQBAJ",
            "etag": "jeT0VSIq3WY",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/DDTdDwAAQBAJ",
            "volumeInfo": {
                "title": "Prose Poetry",
                "subtitle": "An Introduction",
                "authors": [
                    "Paul Hetherington",
                    "Cassandra Atherton"
                ],
                "publisher": "Princeton University Press",
                "publishedDate": "2020-10-13",
                "description": "An engaging and authoritative introduction to an increasingly important and popular literary genre Prose Poetry is the first book of its kind—an engaging and authoritative introduction to the history, development, and features of English-language prose poetry, an increasingly important and popular literary form that is still too little understood and appreciated. Poets and scholars Paul Hetherington and Cassandra Atherton introduce prose poetry’s key characteristics, chart its evolution from the nineteenth century to the present, and discuss many historical and contemporary prose poems that both demonstrate their great diversity around the Anglophone world and show why they represent some of today’s most inventive writing. A prose poem looks like prose but reads like poetry: it lacks the line breaks of other poetic forms but employs poetic techniques, such as internal rhyme, repetition, and compression. Prose Poetry explains how this form opens new spaces for writers to create riveting works that reshape the resources of prose while redefining the poetic. Discussing prose poetry’ s precursors, including William Wordsworth and Walt Whitman, and prose poets such as Charles Simic, Russell Edson, Lydia Davis, and Claudia Rankine, the book pays equal attention to male and female prose poets, documenting women’s essential but frequently unacknowledged contributions to the genre. Revealing how prose poetry tests boundaries and challenges conventions to open up new imaginative vistas, this is an essential book for all readers, students, teachers, and writers of prose poetry.",
                "industryIdentifiers": [
                    {
                        "type": "ISBN_13",
                        "identifier": "9780691212135"
                    },
                    {
                        "type": "ISBN_10",
                        "identifier": "0691212139"
                    }
                ],
                "readingModes": {
                    "text": true,
                    "image": true
                },
                "pageCount": 344,
                "printType": "BOOK",
                "categories": [
                    "Literary Criticism"
                ],
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "2.3.2.0.preview.3",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=DDTdDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=DDTdDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "en",
                "previewLink": "http://books.google.es/books?id=DDTdDwAAQBAJ&pg=PP7&dq=Poetry&hl=&cd=1&source=gbs_api",
                "infoLink": "https://play.google.com/store/books/details?id=DDTdDwAAQBAJ&source=gbs_api",
                "canonicalVolumeLink": "https://play.google.com/store/books/details?id=DDTdDwAAQBAJ"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "FOR_SALE",
                "isEbook": true,
                "listPrice": {
                    "amount": 22.87,
                    "currencyCode": "EUR"
                },
                "retailPrice": {
                    "amount": 21.73,
                    "currencyCode": "EUR"
                },
                "buyLink": "https://play.google.com/store/books/details?id=DDTdDwAAQBAJ&rdid=book-DDTdDwAAQBAJ&rdot=1&source=gbs_api",
                "offers": [
                    {
                        "finskyOfferType": 1,
                        "listPrice": {
                            "amountInMicros": 22870000,
                            "currencyCode": "EUR"
                        },
                        "retailPrice": {
                            "amountInMicros": 21730000,
                            "currencyCode": "EUR"
                        },
                        "giftable": true
                    }
                ]
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "PARTIAL",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.es/books/download/Prose_Poetry-sample-epub.acsm?id=DDTdDwAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "pdf": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.es/books/download/Prose_Poetry-sample-pdf.acsm?id=DDTdDwAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "webReaderLink": "http://play.google.com/books/reader?id=DDTdDwAAQBAJ&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "This volume introduces and provides wide- ranging perspectives on Englishlanguage prose <b>poetry</b>, discussing a broad range of examples. Prose <b>poetry</b> is a highly significant literary form flourishing in most English- speaking countries and&nbsp;..."
            }
        }
    ]
}''',
  'History': '''{
    "kind": "books#volumes",
    "totalItems": 1315,
    "items": [
        {
            "kind": "books#volume",
            "id": "R1IuJs5hwy0C",
            "etag": "FOiVG+at6RI",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/R1IuJs5hwy0C",
            "volumeInfo": {
                "title": "History in a new frontier",
                "authors": [
                    "Association for History and Computing. International Conference"
                ],
                "publisher": "Univ de Castilla La Mancha",
                "publishedDate": "2000",
                "industryIdentifiers": [
                    {
                        "type": "ISBN_10",
                        "identifier": "8484270416"
                    },
                    {
                        "type": "ISBN_13",
                        "identifier": "9788484270416"
                    }
                ],
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 440,
                "printType": "BOOK",
                "categories": [
                    "Historiography"
                ],
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "2.4.4.0.preview.1",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=R1IuJs5hwy0C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=R1IuJs5hwy0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=R1IuJs5hwy0C&pg=PA405&dq=History&hl=&cd=1&source=gbs_api",
                "infoLink": "http://books.google.es/books?id=R1IuJs5hwy0C&dq=History&hl=&source=gbs_api",
                "canonicalVolumeLink": "https://books.google.com/books/about/History_in_a_new_frontier.html?hl=&id=R1IuJs5hwy0C"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "NOT_FOR_SALE",
                "isEbook": false
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "PARTIAL",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false
                },
                "pdf": {
                    "isAvailable": true
                },
                "webReaderLink": "http://play.google.com/books/reader?id=R1IuJs5hwy0C&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "for us to do a different kind of <b>history</b> . A new kind of <b>history</b> . Advance in historical knowledge apart from the simple question of data access . I wanted to turn briefly to cover the second question which wasn&#39;t touched on and that is&nbsp;..."
            }
        }
    ]
}''',
  'Education': '''{
    "kind": "books#volumes",
    "totalItems": 964,
    "items": [
        {
            "kind": "books#volume",
            "id": "xDEOF2vr-r0C",
            "etag": "Bh+P0Jhln24",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/xDEOF2vr-r0C",
            "volumeInfo": {
                "title": "Fundamentos basicos de career education",
                "authors": [
                    "Kenneth B. Hoyt"
                ],
                "publishedDate": "1980",
                "industryIdentifiers": [
                    {
                        "type": "OTHER",
                        "identifier": "MINN:319510028574840"
                    }
                ],
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 64,
                "printType": "BOOK",
                "categories": [
                    "Career education"
                ],
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "0.2.5.0.full.1",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=xDEOF2vr-r0C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=xDEOF2vr-r0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=xDEOF2vr-r0C&pg=PA50&dq=Education&hl=&cd=1&source=gbs_api",
                "infoLink": "https://play.google.com/store/books/details?id=xDEOF2vr-r0C&source=gbs_api",
                "canonicalVolumeLink": "https://play.google.com/store/books/details?id=xDEOF2vr-r0C"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "FREE",
                "isEbook": true,
                "buyLink": "https://play.google.com/store/books/details?id=xDEOF2vr-r0C&rdid=book-xDEOF2vr-r0C&rdot=1&source=gbs_api"
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "ALL_PAGES",
                "embeddable": true,
                "publicDomain": true,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false,
                    "downloadLink": "http://books.google.es/books/download/Fundamentos_basicos_de_career_education.epub?id=xDEOF2vr-r0C&hl=&output=epub&source=gbs_api"
                },
                "pdf": {
                    "isAvailable": false
                },
                "webReaderLink": "http://play.google.com/books/reader?id=xDEOF2vr-r0C&hl=&source=gbs_api",
                "accessViewStatus": "FULL_PUBLIC_DOMAIN",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "Hoyt , Kenneth B. &quot; Career <b>Education</b> for Special Populations . &quot; Monographs on Career <b>Education</b> . Washington , D.C .: U.S. Office of <b>Education</b> . 1976 . ——— 13. &quot; Community Resources for Career <b>Education</b> ."
            }
        }
    ]
}''',
  'Romance': '''{
    "kind": "books#volumes",
    "totalItems": 1349,
    "items": [
        {
            "kind": "books#volume",
            "id": "ZqcL1eVqE8oC",
            "etag": "KgG7MxHNgw0",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/ZqcL1eVqE8oC",
            "volumeInfo": {
                "title": "Observaciones críticas sobre el romance de Gil Blas de Santillana",
                "subtitle": "en las cuales se hace ver que Mr. Le Sage lo desmembró del de El bachiller de Salamanca, entonces manuscrito español inédito",
                "authors": [
                    "Juan Antonio Llorente"
                ],
                "publishedDate": "1822",
                "industryIdentifiers": [
                    {
                        "type": "OTHER",
                        "identifier": "BNC:1001152100"
                    }
                ],
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 420,
                "printType": "BOOK",
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "0.4.8.0.full.1",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=ZqcL1eVqE8oC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=ZqcL1eVqE8oC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=ZqcL1eVqE8oC&pg=PA401&dq=Romance&hl=&cd=1&source=gbs_api",
                "infoLink": "https://play.google.com/store/books/details?id=ZqcL1eVqE8oC&source=gbs_api",
                "canonicalVolumeLink": "https://play.google.com/store/books/details?id=ZqcL1eVqE8oC"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "FREE",
                "isEbook": true,
                "buyLink": "https://play.google.com/store/books/details?id=ZqcL1eVqE8oC&rdid=book-ZqcL1eVqE8oC&rdot=1&source=gbs_api"
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "ALL_PAGES",
                "embeddable": true,
                "publicDomain": true,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false,
                    "downloadLink": "http://books.google.es/books/download/Observaciones_cr%C3%ADticas_sobre_el_romance.epub?id=ZqcL1eVqE8oC&hl=&output=epub&source=gbs_api"
                },
                "pdf": {
                    "isAvailable": true,
                    "downloadLink": "http://books.google.es/books/download/Observaciones_cr%C3%ADticas_sobre_el_romance.pdf?id=ZqcL1eVqE8oC&hl=&output=pdf&sig=ACfU3U2cc_NXzo4j0le_SETtL8FvBmof7g&source=gbs_api"
                },
                "webReaderLink": "http://play.google.com/books/reader?id=ZqcL1eVqE8oC&hl=&source=gbs_api",
                "accessViewStatus": "FULL_PUBLIC_DOMAIN",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "sino desmembracion del otro <b>romance</b> español , inédito por entonces , intitulado Aventuras del Bachiller de Salamanca , que Le Sage publicó despues en 1738 , la cual proposicion está probada mucho mas que bastaba en mi capítulo octavo de&nbsp;..."
            }
        }
    ]
}''',
  'Fantasy': '''{
    "kind": "books#volumes",
    "totalItems": 1567,
    "items": [
        {
            "kind": "books#volume",
            "id": "We2LEAAAQBAJ",
            "etag": "DbuHT9b/yPU",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/We2LEAAAQBAJ",
            "volumeInfo": {
                "title": "Panzer Fantasy",
                "subtitle": "Crónicas Acorazadas en un Mundo Fantástico - Parte I",
                "authors": [
                    "Pablo Garde"
                ],
                "publisher": "Pablo Garde",
                "publishedDate": "2022-09-25",
                "description": "Un capitán y una soldado del Ejército de Tierra español acaban en un mundo de fantasía como el de las obras de ficción que tanto les gustan. Con un carro de combate y su equipo de campaña, tendrán que buscar la forma de encajar en un mundo más complicado de lo que pensaban. Realismo militar, un gran espíritu ochentero y frikismo variopinto se unen en una tragicomedia de acción y aventuras que nace del "Ten cuidado con lo que deseas".",
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 442,
                "printType": "BOOK",
                "categories": [
                    "Biography & Autobiography"
                ],
                "maturityRating": "MATURE",
                "allowAnonLogging": false,
                "contentVersion": "0.0.1.0.preview.1",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=We2LEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=We2LEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=We2LEAAAQBAJ&pg=PP2&dq=Fantasy&hl=&cd=1&source=gbs_api",
                "infoLink": "https://play.google.com/store/books/details?id=We2LEAAAQBAJ&source=gbs_api",
                "canonicalVolumeLink": "https://play.google.com/store/books/details?id=We2LEAAAQBAJ"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "FOR_SALE",
                "isEbook": true,
                "listPrice": {
                    "amount": 0.99,
                    "currencyCode": "EUR"
                },
                "retailPrice": {
                    "amount": 0.99,
                    "currencyCode": "EUR"
                },
                "buyLink": "https://play.google.com/store/books/details?id=We2LEAAAQBAJ&rdid=book-We2LEAAAQBAJ&rdot=1&source=gbs_api",
                "offers": [
                    {
                        "finskyOfferType": 1,
                        "listPrice": {
                            "amountInMicros": 990000,
                            "currencyCode": "EUR"
                        },
                        "retailPrice": {
                            "amountInMicros": 990000,
                            "currencyCode": "EUR"
                        },
                        "giftable": true
                    }
                ]
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "PARTIAL",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false
                },
                "pdf": {
                    "isAvailable": true
                },
                "webReaderLink": "http://play.google.com/books/reader?id=We2LEAAAQBAJ&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "Crónicas Acorazadas en un Mundo Fantástico - Parte I Pablo Garde Escribanía Digital. Copyright © 2022 Pablo Garde Panzer <b>Fantasy</b> Project Todos los derechos reservados. ISBN: 978-84-09-41666-0&nbsp;..."
            }
        }
    ]
}''',
  'Crime': '''{
    "kind": "books#volumes",
    "totalItems": 1330,
    "items": [
        {
            "kind": "books#volume",
            "id": "McHODwAAQBAJ",
            "etag": "HJrvtVe1PN4",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/McHODwAAQBAJ",
            "volumeInfo": {
                "title": "Measuring and analyzing crime against the private sector. International experiences and the Mexican practice",
                "authors": [
                    "INEGI"
                ],
                "publisher": "INEGI",
                "publishedDate": "2014-01-01",
                "readingModes": {
                    "text": false,
                    "image": true
                },
                "pageCount": 277,
                "printType": "BOOK",
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": false,
                "contentVersion": "0.0.1.0.preview.1",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=McHODwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=McHODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "es",
                "previewLink": "http://books.google.es/books?id=McHODwAAQBAJ&pg=PA9&dq=Crime&hl=&cd=1&source=gbs_api",
                "infoLink": "http://books.google.es/books?id=McHODwAAQBAJ&dq=Crime&hl=&source=gbs_api",
                "canonicalVolumeLink": "https://books.google.com/books/about/Measuring_and_analyzing_crime_against_th.html?hl=&id=McHODwAAQBAJ"
            },
            "saleInfo": {
                "country": "ES",
                "saleability": "NOT_FOR_SALE",
                "isEbook": false
            },
            "accessInfo": {
                "country": "ES",
                "viewability": "ALL_PAGES",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": false
                },
                "pdf": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.es/books/download/Measuring_and_analyzing_crime_against_th-sample-pdf.acsm?id=McHODwAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "webReaderLink": "http://play.google.com/books/reader?id=McHODwAAQBAJ&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "Aware that these definitions do not exhaustively describe the complex phenomenon of white collar <b>crime</b>, they are useful because they allow the term white collar <b>crime</b> encompassing both occupational <b>crime</b> and corporate (or&nbsp;..."
            }
        }
    ]
}''',
};

class MockNetworkService extends NetworkService {
  @override
  Future<NetworkResponse> delete(String url) {
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> get(
    String url, {
    Map<String, dynamic> params = const {},
  }) async {
    late final String body;

    final searchTerm = params['q'];

    if (searchTerm != null) {
      body = _bookCategoriesResults[searchTerm]!;
    }

    return NetworkResponse(statusCode: 200, body: body);
  }

  @override
  Future<NetworkResponse> patch(String url,
      {Map<String, dynamic> body = const <String, dynamic>{}}) {
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> post(String url,
      {Map<String, dynamic> body = const <String, dynamic>{}}) {
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> put(String url,
      {Map<String, dynamic> body = const <String, dynamic>{}}) {
    throw UnimplementedError();
  }
}

// TODO: not enough time to finish
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Go to book, add to cart, checkout, pay', (tester) async {
      T findAndGetWidget<T>() {
        final widgetFinder = find.byType(T);

        expect(widgetFinder, findsOneWidget);

        return tester.widget(widgetFinder) as T;
      }

      List<T> findAndGetWidgets<T>(Matcher matcher) {
        final widgetFinder = find.byType(T);

        expect(widgetFinder, matcher);

        return tester.widgetList(widgetFinder) as List<T>;
      }

      app.main();

      networkService = MockNetworkService();

      // main is async. We have to wait.
      await tester.pump(const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final EmailFormField emailFormField = findAndGetWidget();
      final PasswordFormField passwordFormField = findAndGetWidget();
      final WideButton loginButton = findAndGetWidget();

      emailFormField.controller.text = 'user@email.com';
      passwordFormField.controller.text = 'a';

      loginButton.onPressed();

      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 5));
    });
  });
}
