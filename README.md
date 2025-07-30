# Labirinto 3D - Godot

Um jogo simples de labirinto 3D desenvolvido em Godot 4.4.

## Como Jogar

1. **Controle**: Clique com o botão esquerdo do mouse para mover o personagem
2. **Objetivo**: Chegue ao cubo verde para completar o labirinto
3. **Sair**: Pressione ESC para sair do jogo

## Características

- **Controle Point and Click**: Clique onde quiser que o personagem vá
- **Câmera em Terceira Pessoa**: A câmera segue suavemente o personagem
- **Movimento Suave**: O personagem se move e rotaciona suavemente
- **Labirinto 3D**: Ambiente 3D com paredes e colisões
- **Iluminação**: Sistema de iluminação com sombras

## Estrutura do Projeto

```
scenes/
├── Main.tscn          # Cena principal
├── Maze.tscn          # Labirinto com paredes e objetivo
├── Player.tscn        # Personagem jogável
└── UI.tscn           # Interface do usuário

scripts/
├── Player.gd          # Controle do personagem
├── ThirdPersonCamera.gd # Câmera em terceira pessoa
├── Goal.gd            # Objetivo do labirinto
└── UI.gd             # Interface do usuário
```

## Como Executar

1. Abra o projeto no Godot 4.4
2. Pressione F5 ou clique em "Play" para executar
3. Use o mouse para navegar pelo labirinto

## Controles

- **Mouse Esquerdo**: Mover personagem
- **ESC**: Sair do jogo

## Desenvolvimento

Este projeto foi criado como um exemplo de jogo 3D simples em Godot, demonstrando:
- Controle de personagem com raycast
- Câmera em terceira pessoa
- Sistema de colisão 3D
- Interface básica 