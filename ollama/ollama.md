## Ollama
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

sudo docker exec -it ollama ollama run llama2