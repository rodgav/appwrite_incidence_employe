# Incidence app - Employe
project presented by Rodolfo Samuel Gavilan Muñoz for the appwrite hackathon.
* clean architecture
* MVVM
* Responsive (mobile and web)
* internationalization (es-en)

## Get starting
* appwrite v.0.13.4
* flutter v.2.10.3

1. clone project.
2. add the bundle ID to your appwrite project
3. create collections and attributes
    * collections permissions **Document level**
    
    ## incidences

    | attributeId   | type      |              |
    |---------------|-----------|--------------|
    |name           | string    |required      |
    |description    | string    |required      |
    |date_create    | string    |required      |
    |image          | string    |required      |
    |priority       | string    |required      |
    |area           | string    |required      |
    |employe        | string    |required      |
    |supervisor     | string    |required      |
    |solution       | string    |required      |
    |date_solution  | string    |required      |
    |active         | boolean   |required      |
    
    ## areas

    | attributeId   | type      |              |
    |---------------|-----------|--------------|
    |name           | string    |required      |
    |description    | string    |required      |

    ## users

    | attributeId   | type      |              |
    |---------------|-----------|--------------|
    |name           | string    |required      |
    |area           | string    |required      |
    |active         | boolean   |required      |
    |type_user      | string    |required      |

    ## prioritys

    | attributeId   | type      |              |
    |---------------|-----------|--------------|
    |name           | string    |required      |
    
    ## type_users

    | attributeId   | type      |              |
    |---------------|-----------|--------------|
    |name           | string    |required      |

4. create indexes
    ## incidences

    | attributeId   | type      | attributes   |
    |---------------|-----------|--------------|
    |area           | key       | area(asc)    |
    |area_priority  | key       | area(asc), priority(asc)    |
    |area_priority_active  | key       | area(asc), priority(asc), active(asc)    |
    |employe        | key       | employe(asc)    |
    |employe_active | key       | employe(asc), active(asc)    |
    |search         | fulltext  | name(asc)    |

    ## areas

    | attributeId   | type      | attributes   |
    |---------------|-----------|--------------|
    |search         | fulltext  | name(asc)    |

    ## users
    
    | attributeId   | type      | attributes   |
    |---------------|-----------|--------------|
    |typeUser       | key       | type_user(asc)|
    |typeUser_area  | key       | type_user(asc),area(asc)|
    |typeUser_area_active  | key       | type_user(asc),area(asc),active(asc)|
    |search         | fulltext  | name(asc)    |

5.  create documents
    
    ## prioritys

    - Baja, Media, Alta

    ## type_users

    - Employe, Supervisor

6. create bucket **images** 
    * bucket permissions **File level**

7. edit the filename constants.example.dart to constants.dart, fill in your details. the file is located in project/lib/app/constants.example.

## Description
The objective of this project is to facilitate the creation and solution of incidents or incidents that occur within a company or business.

### This project is a part of a complete project.

- [admin](https://github.com/rodgav/appwrite_incidence)
- [supervisor](https://github.com/rodgav/appwrite_incidence_supervisor)
- [employe](https://github.com/rodgav/appwrite_incidence_employe)

### Contains:
- login and forgot password

### Functions:
- create and visualize incidences.

### Screenshots
![incidence-employe](screenshots/incidence-employe.png "incidence-employe")
![login](screenshots/1.-employe-login.png "login")
![forgotPassword](screenshots/2.-employe-forgotPassword.png "forgotPassword")
![main](screenshots/3.-employe-main.png "main")
![incidenceDetail](screenshots/4.-employe-incidenceDetail.png "incidenceDetail")
![incidenceNew](screenshots/5.-employe-incidenceNew.png "incidenceNew")
![userDetails](screenshots/6.-employe-userDetails.png "userDetails")
![changeLanguage](screenshots/7.-employe-changeLanguage.png "changeLanguage")

### Attribution of graphic elements used in the project:
- [Jpg icons created by smalllikeart - Flaticon](https://www.flaticon.com/free-icons/jpg)
- [Vector de niño y adulto creado por freepik - www.freepik.es](https://www.freepik.es/vectores/nino-adulto)
- [appwrite](https://appwrite.io/assets)

### open source projects used
- [appwrite](https://github.com/appwrite/appwrite)
- [dartz](https://github.com/spebbe/dartz)
- [internet_connection_checker](https://github.com/RounakTadvi/internet_connection_checker)
- [get_it](https://github.com/fluttercommunity/get_it)
- [shared_preferences](https://github.com/flutter/plugins/tree/main/packages/shared_preferences/shared_preferences)
- [rxdart](https://github.com/ReactiveX/rxdart)
- [encrypt](https://github.com/leocavalcante/encrypt)
- [go_router](https://github.com/flutter/packages/tree/main/packages/go_router)
- [intl](https://github.com/dart-lang/intl)
- [flutter_phoenix](https://github.com/mobiten/flutter_phoenix)
- [image_picker](https://github.com/flutter/plugins/tree/main/packages/image_picker/image_picker)
- [build_runner](https://github.com/dart-lang/build/tree/master/build_runner)
- [freezed](https://github.com/rrousselGit/freezed)

## Docs
- [flutter documentation](https://flutter.dev/docs).
- [appwrite documentation](https://appwrite.io/docs).

# License

MIT License

Copyright (c) 2022 Rodolfo Samuel Gavilan Muñoz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
