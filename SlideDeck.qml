import QtQuick 2.8
import Qt.labs.presentation 1.0

Presentation {
    id: presentation

    Image {
        anchors.fill: parent
        source: "background.png"
    }

    FontLoader {
        id: titilium
        source: "TitilliumWeb-Regular.ttf"
    }

    FontLoader {
        id: titiliumLight
        source: "TitilliumWeb-Light.ttf"
    }

    fontFamily: titilium.name
    codeFontFamily: titiliumLight.name

    SlideCounter {}
    Clock {}

    Slide {
        centeredText: "<h1>Modern C++</h1><br>" +
                      "por Jesús Fernández (<a href=\"mailto:jesus.fernandez@qt.io\">jesus.fernandez@qt.io</a>)"
    }

    Slide {
        title: "¿Quién soy?"

        content: [
            "Panda Security",
            "Hewlett-Packard",
            "Gameloft",
            "The Qt Company",
            " Mantenedor de QtNetworkAuth",
            " Mantenedor de QtWebGL Streaming Plugin"
        ]
    }

    Slide {
        title: "Cambios en los constructores "

        content: [
            "Inicializar variables",
            "default & delete",
            "Move constructor",
            "Delegar constructores",
            "Final y override"
        ]

        contentWidth: width / 2

        CodeSection {
            fontSize: 16
            text: "struct Example final : Base {
    quint8 integer = 10;
    QObject *pointer = nullptr;
    enum class Enumeration { First = 0, Second }
    std::array<Enumeration, 2> array { Enumeration::First,
        Enumeration::Second };

    Example() = default;
    Example(const Example &) = delete;
        Enumeration::Second };

    Example(quint8 integer, QObject *object) :
        integer(integer), pointer(object) {}

    Example(QObject *object) :
        Example(10, object) {}

    Example(quint8 integer) :
        Example(integer, nullptr) {}

    void baseVirtualFunction(F1) override;
    void baseVirtualFunction(F2) final;
} example;"
        }
    }

    CodeSlide {
        title: "Functiones lambda"
        code: "auto lambdas() {
    quint32 value = 0u;

    value = [] /*()*/ { return 10u; }();
    value = [value] { return value + 1; }();
    value = [] (auto value) { return value + 1; }(value);
    value = [&value] { return ++value; }();
    value = [&] { return ++value; }();

    auto lambda = [value]() mutable { return value + ++value; };
    value = lambda();
    value = lambda();
    value = lambda();

    QTimer::singleShot(value, [](){ qApp->quit(); });

    return value;
}";
    }

    CodeSlide {
        title: "Functiones lambda (2)"
        code: "constexpr int factorial(auto number)
{
    std::function<decltype(factorial(number))()> function;
    function = [&function, value = 0u, number]() mutable
    {
        return number-- > 0 ? ++value * function() : 1;
    };
    return function();
}"
    }

    CodeSlide {
        title: "Punteros inteligentes"
        code: "void smart_pointers() {
    std::unique_ptr<QObject> unique_ptr;
    std::shared_ptr<QObject> shared_ptr;

    unique_ptr.reset(new QObject);
    shared_ptr.reset(new QObject);

    unique_ptr = std::make_unique<QObject>(); // C++14
    shared_ptr = std::make_shared<QObject>();
}"
    }

    CodeSlide {
        title: "auto"
        code: "auto sin_signo = 100u;
auto con_signo = 100;
auto coma_flotante = 1.f;
auto doble_precision = 1.0;
auto cadena = \"cadena\";
auto unique_ptr = std::make_unique<QObject>();
auto shared_ptr = std::make_shared<QObject>();
auto lambda = []{};

void iteradores(const QMap<QString, QList<QObject>> &map)
{
    for (const auto &element : map) {
        auto first = element.cbegin();
        // first = QMap<QString, QList<QObject>>::mapped_type::const_iterator
    }
}
"
    }

    Slide {
        centeredText: "<h1>Preguntas?</h1>"
    }
}
