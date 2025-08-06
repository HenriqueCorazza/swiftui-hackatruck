import SwiftUI
import EventKit

struct AgendaAlarme: View {
    @State private var dataEscolhida = Date.now
    @State private var nomeEvento = ""
    @State private var mostrarAviso = false
    @State private var mensagemAviso = ""
    @State private var listaEventos: [EKEvent] = []
    @State private var eventoASerExcluido: EKEvent? = nil
    @State private var mostrarConfirmacaoExclusao = false

    let calendario = EKEventStore()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blueHacka, Color.blueFarma]),
                           startPoint: .topTrailing,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea(.container, edges: .top)

            ScrollView {
                VStack {
                    // Formulário
                    VStack(spacing: 16) {
                        TextField("Nome do evento", text: $nomeEvento)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        LabeledContent {
                            DatePicker("", selection: $dataEscolhida)
                                .labelsHidden()
                        } label: {
                            Text("Data e Hora:")
                                .font(.headline)
                                .bold()
                        }
                        .padding(.horizontal)

                        Button("Agendar Alarme") {
                            salvarEvento()
                        }
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.white)
                            .shadow(radius: 40)
                    )
                    .frame(width: 350)
                    .padding()

                    // Lista de eventos
                    VStack(spacing: 12) {
                        if listaEventos.isEmpty {
                            Text("Nenhum evento encontrado.")
                                .foregroundColor(.white.opacity(0.8))
                                .shadow(radius: 10)
                                .padding()
                        } else {
                            ForEach(listaEventos, id: \.eventIdentifier) { evento in
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(evento.title)
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(.black)
                                            .shadow(radius: 1)

                                        Text("Data: \(evento.startDate.formatted(date: .abbreviated, time: .shortened))")
                                            .font(.body)
                                            .foregroundColor(.black.opacity(0.9))
                                            .shadow(radius: 1)

                                        if let alarmes = evento.alarms, !alarmes.isEmpty {
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text("Alarmes:")
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                    .bold()

                                                ForEach(alarmes, id: \.self) { alarme in
                                                    let minutos = Int(abs(alarme.relativeOffset) / 60)
                                                    Text("• \(minutos) minuto\(minutos == 1 ? "" : "s") antes")
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                        .fontWeight(.semibold)
                                                }
                                            }
                                            .padding(8)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .foregroundColor(.white.opacity(0.3))
                                            )
                                            .shadow(radius: 1)
                                        }
                                    }
                                    .padding(.trailing, 8)


                                    Button(action: {
                                        eventoASerExcluido = evento
                                        mostrarConfirmacaoExclusao = true
                                    }) {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.red)
                                            .padding(8)
                                            .background(Circle().fill(Color.white))
                                            .shadow(radius: 3)
                                    }
                                    .frame(width: 60, height: 100, alignment: .center)
                                    .offset(x: 20, y: -40)

                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            pedirPermissaoECarregarEventos()
        }
        .alert(isPresented: $mostrarAviso) {
            Alert(title: Text("Agenda"), message: Text(mensagemAviso), dismissButton: .default(Text("OK")))
        }
        .alert("Excluir Evento", isPresented: $mostrarConfirmacaoExclusao, presenting: eventoASerExcluido) { evento in
            Button("Cancelar", role: .cancel) {}
            Button("Excluir", role: .destructive) {
                apagarEvento(evento)
            }
        } message: { evento in
            Text("Tem certeza que deseja excluir o evento \"\(evento.title ?? "Sem título")\"?")
        }
    }

    func pedirPermissaoECarregarEventos() {
        if #available(iOS 17.0, *) {
            calendario.requestFullAccessToEvents { permitido, erro in
                if permitido {
                    carregarEventos()
                } else {
                    mensagemAviso = "Permissão negada pro calendário 😢"
                    mostrarAviso = true
                }
            }
        } else {
            calendario.requestAccess(to: .event) { permitido, erro in
                if permitido {
                    carregarEventos()
                } else {
                    mensagemAviso = "Permissão negada pro calendário 😢"
                    mostrarAviso = true
                }
            }
        }
    }

    func carregarEventos() {
        let agora = Date()
        let daquiUmMes = Calendar.current.date(byAdding: .day, value: 30, to: agora)!
        let filtro = calendario.predicateForEvents(withStart: agora, end: daquiUmMes, calendars: nil)
        let eventosAchados = calendario.events(matching: filtro)

        DispatchQueue.main.async {
            self.listaEventos = eventosAchados.sorted(by: { $0.startDate < $1.startDate })
        }
    }

    func salvarEvento() {
        if #available(iOS 17.0, *) {
            calendario.requestFullAccessToEvents { permitido, erro in
                if permitido {
                    criarEGravarEvento()
                } else {
                    mensagemAviso = "Permissão ao calendário foi negada."
                    mostrarAviso = true
                }
            }
        } else {
            calendario.requestAccess(to: .event) { permitido, erro in
                if permitido {
                    criarEGravarEvento()
                } else {
                    mensagemAviso = "Permissão ao calendário foi negada."
                    mostrarAviso = true
                }
            }
        }
    }

    private func criarEGravarEvento() {
        let evento = EKEvent(eventStore: calendario)
        evento.title = nomeEvento.isEmpty ? "Lembrete" : nomeEvento
        evento.startDate = dataEscolhida
        evento.endDate = dataEscolhida.addingTimeInterval(30 * 60)
        evento.calendar = calendario.defaultCalendarForNewEvents

        let alarmeCincoMinAntes = EKAlarm(relativeOffset: -300)
        let alarmeNaHora = EKAlarm(relativeOffset: 0)
        evento.alarms = [alarmeCincoMinAntes, alarmeNaHora]

        do {
            try calendario.save(evento, span: .thisEvent)
            DispatchQueue.main.async {
                mensagemAviso = "Evento '\(evento.title)' criado com sucesso e com alarmes 🚨"
                mostrarAviso = true
                nomeEvento = ""
                dataEscolhida = Date.now
                carregarEventos()
            }
        } catch {
            DispatchQueue.main.async {
                mensagemAviso = "Erro ao salvar evento: \(error.localizedDescription)"
                mostrarAviso = true
            }
        }
    }

    func apagarEvento(_ evento: EKEvent) {
        do {
            try calendario.remove(evento, span: .thisEvent)
            carregarEventos()
        } catch {
            mensagemAviso = "Erro ao remover evento: \(error.localizedDescription)"
            mostrarAviso = true
        }
    }
}

#Preview {
    AgendaAlarme()
}
