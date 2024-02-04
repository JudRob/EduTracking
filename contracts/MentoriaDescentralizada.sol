// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MentoriaDescentralizada {
    // Estructura de datos para representar a un estudiante
    struct Estudiante {
        address direccion;
        string nombre;
        bool estaEmparejado;
        address mentor;
    }

    // Estructura de datos para representar a un mentor
    struct Mentor {
        address direccion;
        string nombre;
        bool estaEmparejado;
        address estudiante;
    }

    // Almacena a los estudiantes y mentores registrados
    mapping(address => Estudiante) public estudiantes;
    mapping(address => Mentor) public mentores;

    // Evento emitido cuando se realiza una nueva asignación de tutoría
    event Emparejamiento(address indexed estudiante, address indexed mentor);

    // Función para que un estudiante se registre en la plataforma
    function registrarEstudiante(string memory _nombre) public {
        require(estudiantes[msg.sender].direccion == address(0), "Estudiante ya registrado");
        estudiantes[msg.sender] = Estudiante(msg.sender, _nombre, false, address(0));
    }

    // Función para que un mentor se registre en la plataforma
    function registrarMentor(string memory _nombre) public {
        require(mentores[msg.sender].direccion == address(0), "Mentor ya registrado");
        mentores[msg.sender] = Mentor(msg.sender, _nombre, false, address(0));
    }

    // Función para emparejar un estudiante con un mentor
    function emparejarEstudiante(address _mentor) public {
        require(estudiantes[msg.sender].direccion != address(0), "Estudiante no registrado");
        require(mentores[_mentor].direccion != address(0), "Mentor no registrado");
        require(!estudiantes[msg.sender].estaEmparejado, "Estudiante ya emparejado");
        require(!mentores[_mentor].estaEmparejado, "Mentor ya emparejado");

        // Realizar el emparejamiento
        estudiantes[msg.sender].estaEmparejado = true;
        estudiantes[msg.sender].mentor = _mentor;
        mentores[_mentor].estaEmparejado = true;
        mentores[_mentor].estudiante = msg.sender;

        // Emitir evento de emparejamiento
        emit Emparejamiento(msg.sender, _mentor);
    }

    // Función para que un estudiante actualice su progreso
    function actualizarProgreso(address _mentor, string memory _informe) public {
        require(estudiantes[msg.sender].direccion != address(0), "Estudiante no registrado");
        require(estudiantes[msg.sender].estaEmparejado, "Estudiante no emparejado");
        require(estudiantes[msg.sender].mentor == _mentor, "No emparejado con este mentor");

        // Podrías agregar lógica adicional aquí para procesar el informe de progreso

        // Por simplicidad, solo emitimos un evento en este ejemplo
        emit InformeProgreso(msg.sender, _mentor, _informe);
    }

    // Evento para informar sobre el progreso
    event InformeProgreso(address indexed estudiante, address indexed mentor, string informe);

     // Función para que un estudiante envíe un informe de progreso al mentor
    function informarProgreso(address _mentor, string memory _informe) public {
        require(estudiantes[msg.sender].estaEmparejado, "Estudiante no emparejado");
        require(estudiantes[msg.sender].mentor == _mentor, "No es el mentor correcto");

        // Emitir el evento de informe de progreso
        emit InformeProgreso(msg.sender, _mentor, _informe);
    }

}