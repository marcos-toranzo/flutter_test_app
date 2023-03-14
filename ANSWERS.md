- ¿Qué patrones de arquitectura se pueden utilizar en Flutter?

  Flutter es muy flexible. Soporta patrones de arquitectura como MVC, MVVM, o híbrido. Es muy raro encontrarse con una app desarrollada en Flutter que use alguno en estado puro. Podemos encontrar patrones como `GetX`, que usa controllers para mediar entre las interacciones del usuario con la UI y los datos, y responder a cambios de esta a través de observables que, al cambiar, re-renderizan la UI según esa interacción. También encontramos el patrón `BLoC`. Este usa Streams de eventos para escuchar por las interacciones del usuario. Una vez un evento es capturado en el Stream, se devuelve un estado a la UI presentando la nueva información a mostrar en la UI. Otro patrón popular es `Provider`. Este permite a los widgets escuchar cambios en distintos providers cuando estos indiquen que hay cambios, interactuando el widget con el provider cuando hay interacción del usuario en la UI y el provider respondiendo con un cambio en la información, re-renderizando todos los widgets que están "escuchándolo".
  
- ¿Qué es el widget Testing en Flutter y cómo se puede implementar?

  Widget Testing es el equivalente a Uni Testing, pero tomando como unit a un widget. Se puede implementar usando la función `testWidget` que ofrece un `WidgetTester` como callback que permite la interacción con los widgets: `pumpWidget` para añadir un widget al árbol. También ofrece un `Finder` para encontrar widgets específicos. Por ejemplo, `find.text` permite buscar widgets de tipo `Text`. Luego podemos usar `Matcher`s para hacer aserciones sobre esos widgets, como por ejemplo `findsOneWidget` o `findsNothing` que permite saber si se encontró 1 o ningún widget de ese tipo, respectivamente.

- ¿Cuál es la diferencia entre StatelessWidget y `StatefulWidget` en Flutter?
  
  La diferencia radica en la presencia o no de un estado interno. En el caso de los `StatelessWidgets`, estos no presentan estado interno, es decir, una vez que se renderizan con los parámetros indicados su estado interno no cambia (el método `build` se llama una sola vez). En el caso contrario, los `StatefulWidget`s mantienen un estado interno que les permite re-renderizarse luego de haber sido construidos (llamando a la funcion `setState`, llamando al método `build` cada vez que el estado cambia).

- ¿Qué es un widget en Flutter? ¿Cómo se relaciona con el árbol de widgets?

  En Flutter un widget es la unidad básica de UI. Cualquier elemento que se renderiza es un widget. El árbol de widgets es la analogía al DOM en la web. Mientras vamos componiendo widgets estos se van añadiendo al árbol de widgets. Se comiendo por el widget que se le pasa a la función `runApp` del `main`, tomando ese widget como raíz del arbol (generalmente un `MaterialApp`). A medida que vamos añadiendo widgets dentro de widgets, estos se van añadiendo como hijos los widgets que lo llaman, creándose el árbol de widgets con esa distribución.

- ¿Cuál es la función del método initState() en StatefulWidget?

  Como los `StatefulWidget`s tienen estados internos, cuentan con métodos de ciclo de vida como `initState()`, `didChangeDependencies()` o `dispose()` (entre otros). Estos métodos son llamados en diferentes partes del ciclo de vida del widget. `initState()` es el que se llama cuando se va a inicializar el estado del widget. Este método se llama una sola vez durante todo el ciclo de vida del widget y es util para inicializar variables que necesitan un pequeño cálculo o controladores para animaciones, etc.

- ¿Cómo se manejan las rutas de navegación en Flutter?

  El SDK viene con la clase `Navigator` que permite manipular las rutas. Contiene métodos como `push` para añadir una ruta a la pila de navegación y renderizarla, `pop` para sacar la ruta actual de la pila y regresar a la anterior, `pushReplacement` para primero hacer `push` y luego `pop` a la que estaba anteriormente, o sus versiones `...Named` para usar el nombre de la ruta en vez de un builder de la página. Estos nombres deben estar definidos en la propiedad `routes` del widget `MaterialApp`. También se puede usar la propiedad `onGenerateRoute` para procesar la ruta que se quiere generar manualmente. En casos más complejos (con múltiples `Navigator`s, generalmente en web) se puede usar `Router`.

- ¿Cómo se manejan las animaciones en Flutter?

  Hay muchos modos de animar en Flutter. La forma más básica es el widget `Animation`, que interpola entre dos valores con una curva dada (linear, stepper, etc). Se pueden usar para animar muchas propiedades de los widgets, como las dimensiones, los colores, etc. Las animaciones requieren de un `AnimationController`, un controllar que requiere de un widget que implemente el mixin `SingleTickerProviderStateMixin` pues se le pasa al parámetro `vsync`. Este controller se le suministra a los diferentes tipos de animaciones, como `Tween`, `CurvedAnimation` o cualquier animación personalizada. El controlador posee funciones como `forward()` y `reverse()` para controlar la dirección de la animación. Al mismo tiempo las animaciones permiten subscripciones a sus estados y cambios con las funciones `addListener()` y `addStatusListener()`. Se puede acceder al valor actual de una animación por la propiedad `value`. La forma más básica de implementarla es:
  - teniendo un `StatefulWidget` cuyo estado implementa el mixin `SingleTickerProviderStateMixin`.
  - creando el `AnimationController` con los valores deseados y pasarle como `vsync: this`.
  - creando una animación como `Tween` y hacerle `.animate(controller)` para asociar el controlador a la animación.
  - añadiendo un listener a la animación para hacer un `setState()` cada vez que cambia su valor.
  - usar `animation.value` en el widget que querramos animar.

  Esta forma es un poco engorrosa. Por eso Flutter ofrece widgets que aceptan una animación como parámetro y no necesita mantener un estado para cambiar acorde a la animación. Ejemplos: `SizeTransition`, `AnimatedWidget`, `RotationTransition`, etc. También posee un `AnimationBuilder` que permite separar la animación del widget. Acepta una animación y un widget al que le será pasado esa animación. El widget debe saber como manipular esa animación.

- ¿Cuáles son los widgets principales utilizados para crear formularios en Flutter?

  Para crear formularios Flutter cuenta con widgets como `Form`, que permite agrupar todos los `FormField`s hijos y tratarlos a todos al mismo tiempo, permitiendo un modo de validación global, escuchando a cualquier cambio en sus hijos o evitando que el user cancele el formulario sin querer. Al `Form` podemos suministrarle `FormField`s como `DropdownButtonFormField` o`TextFormField`. Este último permite validadores, formateadores, etc.

- ¿Qué es un FutureBuilder en Flutter? ¿Cómo lo utilizas?

  Un `FutureBuilder` es un widget que permite escuchar a un `Future` e informar de su estado para renderizar widgets en función de ese estado. Recibe un `Future` a escuchar y un `builder`, que expone un `AsyncSnapshot` que nos permite saber si ya el `Future` terminó, si está funcionando aún, si tiene errores, etc, para poder renderizar widgets acorde a su estado.

- ¿Cuál es la función del método dispose() en StatefulWidget?

  Como explicado anteriormente, `dispose()` es un método del ciclo de vida del widget. Es el último método llamado cuando el widget es removido del árbol. Se llama una sola vez. Es útil para eliminar (dispose) elementos que pueden presentar una fuga de memoria, como `TextEditingController`s o `AnimationController`s.

- ¿Cómo se manejan los errores y excepciones en Flutter?

  La diferencia principal entre errores y excepciones en Flutter es que un error es una excepción provocada por un error en la programación, indicando que algo está mal con el código en si. Estos errores deben ser lanzados, pero no capturados. La idea es que estas excepciones se muestren cuando algo está mal implementado. En el caso de las excepciones nos encontramos con el caso común: errores en tiempo de ejecución. Estas excepciones sí están diseñadas para ser capturadas. Dart ofrece el bloque estandard `try catch` para capturar excepciones y errores.

- ¿Qué es un StreamBuilder en Flutter? ¿Cómo lo utilizas?

  El `StreamBuilder` es análogo al `FutureBuilder`, solo que en vez de escuchar a un `Future`, escucha a un `Stream`.
  
